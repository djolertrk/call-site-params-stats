# call-site-params-stats
This is based on LLVM project and it checks the quality of the described (target-) instructions in terms of DWARF for call-site-params/entry-values feature.

The idea is to find instructions that are frequently used, but not described for the call-site-param value (DW_AT_GNU_call_site_value).

On a very high level, the Debug Entry Values feature implementation ended up performing describing target instructions that load a value into registers that are used to transfer function parameters. Debuggers use that information to print @entry value within debuggers (and we allow debuggers to try to evaluate DW_OP_entry_value expressions within location lists).
