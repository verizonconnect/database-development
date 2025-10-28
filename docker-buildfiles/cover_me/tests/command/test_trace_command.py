import pytest
import sys
from unittest import mock
from typing import List, Any
from collections import namedtuple

# Adjust imports based on your final project structure
# Import the main command file
from src.command.trace import TraceCommand 
from src.command.base import BaseCommand
from src.config import Config
from src.dumper.reified_procedure import QualifiedName, SkeletonProcedure

# --- MOCK DATA STRUCTURES ---

# Helper structure for test procedures, mimicking ReifiedProcedure's minimal requirements
MockProcedure = namedtuple("MockProcedure", ["oid", "name", "signature", "source_path", "filters"])

# --- FIXTURE MOCKS ---

@pytest.fixture
def mock_procedure_list():
    """Returns a list of mock procedure objects with necessary methods."""
    
    # --- 1. Define the necessary instance methods ---
    def mock_oid(self): return str(self.oid_value) # Accesses 'oid_value' set in __init__
    def mock_sig(self): return f"public.{self.name_value}(id)"
    def mock_path(self, config): return f"/cache/dumper/{self.oid_value}.sql"
    
    # --- 2. Define the Constructor ---
    def mock_init(self, oid, name):
        # Assign the incoming args to attributes the mock methods can access
        self.oid_value = oid
        self.name_value = name
        # Initialize the QualifiedName structure needed for filtering/config interaction
        self.name = QualifiedName("public", name) 

    # --- 3. Create the MockProc Type with Constructor ---
    MockProc = type('MockProc', (object,), {
        '__init__': mock_init,            # <-- ADDS THE CONSTRUCTOR
        'oid': property(mock_oid),
        'signature': property(mock_sig),
        'source_path': mock_path,
        # Other methods are inherited or dynamically added in __init__
    })
    
    # --- 4. Instantiate the procedures (Now works) ---
    return [
        MockProc(oid=1001, name="proc_a"),
        MockProc(oid=1002, name="proc_b"),
    ]

@pytest.fixture
def mock_config():
    """Returns a mock Config object."""
    config = Config()
    config.filters = [] # Start with no filters
    config.dry_run = False
    return config

# --- TEST HARNESS ---

# We use autouse=True to apply the patches before any test function runs
# The patches simulate the external environment/dependencies
@mock.patch('src.command.trace.ProcessQueue')
@mock.patch('src.command.trace.Installer')
@mock.patch('src.command.trace.Profile')
@mock.patch('src.command.trace.TraceCompiler')
@mock.patch('src.command.trace.Dumper.Index')
@mock.patch('src.command.trace.TraceCommand.configure', autospec=True)
@mock.patch('src.command.base.BaseCommand.connect', autospec=True)
@mock.patch('src.command.trace.TraceCommand.dump', autospec=True)
@mock.patch('src.command.base.BaseCommand.filter', autospec=True)
def test_trace_command_execution_flow(
    mock_base_filter, mock_trace_dump, mock_base_connect, mock_trace_configure, 
    MockIndex, MockTraceCompiler, MockProfile, MockInstaller, MockProcessQueue,
    mock_procedure_list, mock_config, capsys
):
    """
    Tests the main execution path of TraceCommand.execute to ensure correct 
    sequence of calls (configure, connect, dump, filter, trace, install).
    """
    # --- Setup Mock Return Values ---
    
    # Mock configuration return
    mock_trace_configure.return_value = mock_config
    
    # Mock procedure return from BaseCommand.filter
    mock_base_filter.return_value = mock_procedure_list
    
    # Mock installer instantiation
    MockInstaller.return_value = mock.MagicMock() 

    # --- EXECUTE ---
    print(f'test_trace_command_execution_flow - before')
    TraceCommand.execute(["trace_command"])
    print(f'test_trace_command_execution_flow - after')

    # --- ASSERTIONS ---
    
    # 1. Initialization and Data Gathering
    mock_trace_configure.assert_called_once()
    mock_base_connect.assert_called_once_with(mock_config)
    
    MockIndex.assert_called_once_with(mock_config)
    mock_trace_dump.assert_called_once_with(mock_base_connect.return_value, MockIndex.return_value)
    
    mock_base_filter.assert_called_once_with(mock_config, MockIndex.return_value)

    # 2. Trace and Install Calls
    MockTraceCompiler.assert_called_once_with(mock_config)
    
    # Check that TraceCommand.trace was called with the mock procedures
    # This also checks that TraceCommand.trace successfully called ProcessQueue.execute()
    MockProcessQueue.return_value.execute.assert_called_once()

    # Check that the Installer was instantiated correctly
    MockInstaller.assert_called_once_with(mock_config, mock_base_connect.return_value)
    
    # Check that TraceCommand.install was executed
    MockInstaller.return_value.install.assert_called_once_with(
        mock_procedure_list, MockProfile.return_value
    )

# --- DRY RUN TEST ---

#@mock.patch('src.command.trace.BaseCommand.filter', autospec=True)
#@mock.patch('src.command.trace.TraceCommand.configure')
#def test_trace_command_dry_run(
#    mock_trace_configure, mock_base_filter, mock_procedure_list, mock_config, capsys
#):
#    """
#    Tests the dry-run path: should print signatures and exit without compiling or installing.
#    """
#    # --- Setup Mock Return Values ---
#    
#    mock_config.dry_run = True # Set dry_run flag
#    mock_trace_configure.return_value = mock_config
#    mock_base_filter.return_value = mock_procedure_list
#    
#    # --- EXECUTE ---
#    # We expect sys.exit(0) to be called, so we must catch SystemExit
#    with pytest.raises(SystemExit) as cm:
#        print(f'test_trace_command_dry_run - before')
#        TraceCommand.execute(["trace_command"])
#    
#    # --- ASSERTIONS ---
#    
#    # Check that sys.exit(0) was called
#    assert cm.value.code == 0
#    
#    # Check output: signatures should be printed
#    captured = capsys.readouterr()
#    expected_output = "\n".join([p.signature for p in mock_procedure_list]) + "\n"
#    assert captured.out == expected_output