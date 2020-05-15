#!/usr/bin/python
#
# Evaluate the call site parameter's description.
#

import sys

def main():
  # Used for tracking the opcode-name pairs.
  instr_map = dict()
  with open("instrNames.txt","r") as instr_names_file:
    for line in instr_names_file:
      instr = line.split(" ")
      opc = instr[0]
      name = instr[1]
      name = name.rstrip("\n")
      instr_map[opc]=name

    # Collect "#hit" and "#miss" from "descrInstrLog.txt" for all modules.
    with open("descrInstrLog.txt", "r") as stats_log_file:
      lines = stats_log_file.readlines()
      i = 0
      opc = 0
      miss = 0
      hit = 0
      misses = [0 for l in range(20000)]
      hits = [0 for m in range(20000)]
      total_freq = 0;
      for line in lines:
        for s in line.split(' '):
          try:
            data = int(s)
          except ValueError:
            continue

          if (i == 2):
            hit = data
            total_freq = total_freq + hit + miss
            misses[opc] = misses[opc] + miss
            hits[opc] = hits[opc] + hit
          else:
            if (i == 1):
              miss = data
            else:
              opc = data
          i = (i + 1) % 3

  # Output collected data.
  print ("=================================================================================")
  print ("\t\tDescribing DW_AT_call_site_value EFFICIENCY")
  print ("=================================================================================")
  print ("INSTRUCTION\t(freq)  \t   #MISS      \t    #HIT     \t  MISS PERCENTAGE")
  print ("---------------------------------------------------------------------------------")
  total_hit = 0;
  total_miss = 0;
  for k in range(20000):
    if (misses[k] > 0 or hits[k] > 0):
      total_miss = total_miss + misses[k]
      total_hit = total_hit + hits[k]
      opc = k
      opc_f = 100 * (misses[k] + hits[k]) / total_freq
      miss = misses[k]
      hit = hits[k]
      per = 100 * (miss) / (miss + hit)
      print ("{0:<20}".format(instr_map[str(opc)]) + "(" + str(opc_f) + "%)\t" + \
             "{0:>8}".format(miss) + \
             "\t" + "{0:>8}".format(hit) + "\t\t" + "{0:>5}".format(per) + "%")
  print ("---------------------------------------------------------------------------------")
  per = 100 * (total_miss) / (total_miss + total_hit)
  print ("TOTAL MISS PERCENTAGE: " + str(per) + "%")
  print ("=================================================================================")

if __name__== "__main__":
  # Please use Python2.
  # TODO: Port this to Python3.
  if sys.version_info > (2, 7, 18):
    sys.stderr.write("Please use python2.\n")
    exit (1)

  main()
