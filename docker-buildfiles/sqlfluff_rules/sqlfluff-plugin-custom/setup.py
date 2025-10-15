from setuptools import setup

setup(
    name="sqlfluff-plugin-custom",
    version="0.1.0",
    python_requires=">=3.9",
    install_requires=[
        "sqlfluff>=3.1.0"
    ],
    entry_points={
        "sqlfluff": [
            "sqlfluff_custom = sqlfluff_plugin_custom",
        ],
    },
)
