"""
MySQL coverage profile — reads hits from the MyISAM trace table.
"""
from cover_me.profile import Profile


def parse_trace_table(connection, profile: Profile) -> int:
    """Read coverage hits from cover_me.trace table. Returns hit count."""
    hits = 0
    with connection.cursor(dictionary=True) as cur:
        cur.execute("SELECT tag_id, value FROM cover_me.trace")
        for row in cur.fetchall():
            profile.ping(row["tag_id"], row["value"])
            hits += 1
    return hits
