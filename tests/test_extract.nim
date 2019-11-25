import unittest

import strpkg/extract
import strpkg/utils

suite "extract suite":
  test "that reads with clips get mates assigned to same location":

    # K00280:79:HMVTNBBXX:8:1125:19360:9297	129	chr16	17470852	60	71M80S	chr2	86914345	0	CCCCGCGCTCCCCGCAGCTCCCGCGGCCGCCGGCTGCCGCTCGGGCTCCCGCTCGGGCCGCCGCCGCCGCCGCCGCCTCGGCTCGCCGCCGCTCCGCCGCCGCCGCCGCCGCCGCCGCCGCCCCCGCCGCCGCCGCCGCCGCCGCCGCCCC	AAFFFJJJJJJJJJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ<JJJJJJJJJFJJJJJFJJJJJJJF)7--A)AAAA-A)A7)<FF7-<FJ--<<7F7-<<----F)-)--<))A-FJJ<F)--)--)<-))--7--7)))	NM:i:0	MD:Z:71	MC:Z:21M13D27M13D69M7D34M	AS:i:71	XS:i:29	SA:Z:chr2,86914418,-,1S57M93S,0,1;	RG:Z:d4674-1_022318_hg19amy

    # K00280:79:HMVTNBBXX:8:1125:19360:9297	65	chr2	86914345	0	21M13D27M13D69M7D34M	chr16	17470852	0	GGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCGGCG	AAFFFJJJJJFJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJFJFJJJJJJFJJJ<JJJJJJJJJJJJJJJJJJAJJJJJJJJJJJJJFJAJFJFJFJJJJJJJFJFJAAF7<A7FJJ-F-AFJ7JJ<JFJJF-JJFJFAJJ7-A)AA-	NM:i:38	MD:Z:21^CTCGACCTGGCCG27^CTCGACCTGGCCG57C0T4C0T4^CTGGCCG3T30	MC:Z:71M80S	AS:i:75	XS:i:71	RG:Z:d4674-1_022318_hg19amy

    var A = tread(tid: 2, position: 86914345, repeat: ['C', 'C', 'G', '\0', '\0', '\0'], mapping_quality: 10, repeat_count: 40, align_length: 80)
    var B = tread(tid: 16, position: 17470852, split: Soft.none_right, mapping_quality: 60, repeat_count: 0, align_length: 71)

    var opts = Options(proportion_repeat: 0.4, min_mapq: 20)


    check A.adjust_by(B, opts)
    check A.position == B.position