From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] urcu-mb/signal/membarrier: batch
	concurrent	synchronize_rcu()
Date: Mon, 26 Nov 2012 15:01:46 -0500
Message-ID: <20121126200146.GA30509__20123.5202177942$1353960832$gmane$org@Krystal>
References: <20121126032220.GA19034@Krystal> <50B2E8FB.4000906@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Td4sG-0007n6-JE
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 15:01:48 -0500
Content-Disposition: inline
In-Reply-To: <50B2E8FB.4000906@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Hi Lai,

Here are the raw results you asked for. I only did a single run for
each, and did not specify any CPU affinity, so please keep in mind that
results can vary due to NUMA access effects. But the trend is clear:
when we have 3 or more updaters, batching is quite effective. With 1-2
updaters, the results vary between a small speedup for batching (for 1
updater) to a small slowdown for batching (2 updaters). I don't have
good explanation for the 1-updater speedups, except maybe that accessing
a mutex cache-line with a xchg() first might speed things up, but this
is really just a guess.

Thoughts ?

* Serialized synchronize_rcu() -- test_urcu (mb)

./test_urcu 4 1 20
SUMMARY ./test_urcu               testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads    222512859 nr_writes     10723654 nr_ops    233236513
./test_urcu 4 20 20
SUMMARY ./test_urcu               testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads    722096653 nr_writes      5012429 nr_ops    727109082
./test_urcu 12 12 20
SUMMARY ./test_urcu               testdur   20 nr_readers  12 rdur      0 wdur      0 nr_writers  12 wdelay      0 nr_reads   1822868768 nr_writes      2300787 nr_ops   1825169555
./test_urcu 16 8 20
SUMMARY ./test_urcu               testdur   20 nr_readers  16 rdur      0 wdur      0 nr_writers   8 wdelay      0 nr_reads   2355908375 nr_writes      1604850 nr_ops   2357513225
./test_urcu 20 4 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   4 wdelay      0 nr_reads   3003457459 nr_writes      1074828 nr_ops   3004532287
./test_urcu 20 3 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   3 wdelay      0 nr_reads   2956972543 nr_writes      1036556 nr_ops   2958009099
./test_urcu 20 2 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   2 wdelay      0 nr_reads   2890178860 nr_writes      1030095 nr_ops   2891208955
./test_urcu 20 1 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   3017482290 nr_writes       783420 nr_ops   3018265710

* Batched synchronize_rcu() -- test_urcu (mb)

./test_urcu 4 1 20
SUMMARY ./test_urcu               testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads    271476751 nr_writes     12858885 nr_ops    284335636
./test_urcu 4 20 20
SUMMARY ./test_urcu               testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads    608488583 nr_writes     10080610 nr_ops    618569193
./test_urcu 12 12 20
SUMMARY ./test_urcu               testdur   20 nr_readers  12 rdur      0 wdur      0 nr_writers  12 wdelay      0 nr_reads   1260044362 nr_writes      7957711 nr_ops   1268002073
./test_urcu 16 8 20
SUMMARY ./test_urcu               testdur   20 nr_readers  16 rdur      0 wdur      0 nr_writers   8 wdelay      0 nr_reads   2048890674 nr_writes      5440985 nr_ops   2054331659
./test_urcu 20 4 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   4 wdelay      0 nr_reads   2819267217 nr_writes      3093008 nr_ops   2822360225
./test_urcu 20 3 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   3 wdelay      0 nr_reads   3067795320 nr_writes      2817760 nr_ops   3070613080
./test_urcu 20 2 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   2 wdelay      0 nr_reads   3116770603 nr_writes      2404242 nr_ops   3119174845
./test_urcu 20 1 20
SUMMARY ./test_urcu               testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads   2238534130 nr_writes      3737588 nr_ops   2242271718


* Serialized synchronize_rcu() -- test_urcu_signal

./test_urcu_signal 4 1 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  16063309841 nr_writes         9217 nr_ops  16063319058
./test_urcu_signal 4 20 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads  16065183739 nr_writes         9182 nr_ops  16065192921
./test_urcu_signal 12 12 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  12 rdur      0 wdur      0 nr_writers  12 wdelay      0 nr_reads  48028512672 nr_writes         8890 nr_ops  48028521562
./test_urcu_signal 16 8 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  16 rdur      0 wdur      0 nr_writers   8 wdelay      0 nr_reads  64001589198 nr_writes         8756 nr_ops  64001597954
./test_urcu_signal 20 4 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   4 wdelay      0 nr_reads  79907434070 nr_writes         9068 nr_ops  79907443138
./test_urcu_signal 20 3 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   3 wdelay      0 nr_reads  79987250839 nr_writes         8589 nr_ops  79987259428
./test_urcu_signal 20 2 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   2 wdelay      0 nr_reads  79749947176 nr_writes         8596 nr_ops  79749955772
./test_urcu_signal 20 1 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  79751023090 nr_writes         8624 nr_ops  79751031714

* Batched synchronize_rcu() -- test_urcu_signal

./test_urcu_signal 4 1 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  15739087241 nr_writes         9218 nr_ops  15739096459
./test_urcu_signal 4 20 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads  15662135806 nr_writes        94833 nr_ops  15662230639
./test_urcu_signal 12 12 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  12 rdur      0 wdur      0 nr_writers  12 wdelay      0 nr_reads  46634363289 nr_writes        56903 nr_ops  46634420192
./test_urcu_signal 16 8 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  16 rdur      0 wdur      0 nr_writers   8 wdelay      0 nr_reads  62263951759 nr_writes        39058 nr_ops  62263990817
./test_urcu_signal 20 4 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   4 wdelay      0 nr_reads  77799768623 nr_writes        21065 nr_ops  77799789688
./test_urcu_signal 20 3 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   3 wdelay      0 nr_reads  76408008440 nr_writes        17026 nr_ops  76408025466
./test_urcu_signal 20 2 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   2 wdelay      0 nr_reads  77868927424 nr_writes        12630 nr_ops  77868940054
./test_urcu_signal 20 1 20
SUMMARY ./test_urcu_signal        testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  77293186844 nr_writes         8680 nr_ops  77293195524


* Serialized synchronize_rcu() -- test_urcu_qsbr

./test_urcu_qsbr 4 1 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  18841016559 nr_writes      1857130 nr_ops  18842873689
./test_urcu_qsbr 4 20 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads  20272811733 nr_writes      1837027 nr_ops  20274648760
./test_urcu_qsbr 12 12 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  12 rdur      0 wdur      0 nr_writers  12 wdelay      0 nr_reads  60343516643 nr_writes      2353685 nr_ops  60345870328
./test_urcu_qsbr 16 8 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  16 rdur      0 wdur      0 nr_writers   8 wdelay      0 nr_reads  78202711840 nr_writes      2326331 nr_ops  78205038171
./test_urcu_qsbr 20 4 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   4 wdelay      0 nr_reads  94553396003 nr_writes      2238396 nr_ops  94555634399
./test_urcu_qsbr 20 3 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   3 wdelay      0 nr_reads  95004708661 nr_writes      2165966 nr_ops  95006874627
./test_urcu_qsbr 20 2 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   2 wdelay      0 nr_reads  95386506198 nr_writes      2194352 nr_ops  95388700550
./test_urcu_qsbr 20 1 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  84705972017 nr_writes      2609595 nr_ops  84708581612

* Batched synchronize_rcu() -- test_urcu_qsbr

./test_urcu_qsbr 4 1 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  19154850714 nr_writes      2238834 nr_ops  19157089548
./test_urcu_qsbr 4 20 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads  15114131760 nr_writes      9370255 nr_ops  15123502015
./test_urcu_qsbr 12 12 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  12 rdur      0 wdur      0 nr_writers  12 wdelay      0 nr_reads  45541854970 nr_writes      5786496 nr_ops  45547641466
./test_urcu_qsbr 16 8 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  16 rdur      0 wdur      0 nr_writers   8 wdelay      0 nr_reads  66217337547 nr_writes      4257427 nr_ops  66221594974
./test_urcu_qsbr 20 4 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   4 wdelay      0 nr_reads  95048642908 nr_writes      2416266 nr_ops  95051059174
./test_urcu_qsbr 20 3 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   3 wdelay      0 nr_reads  96679609928 nr_writes      2211168 nr_ops  96681821096
./test_urcu_qsbr 20 2 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   2 wdelay      0 nr_reads  92166219811 nr_writes      1968725 nr_ops  92168188536
./test_urcu_qsbr 20 1 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers  20 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  87986181951 nr_writes      3278737 nr_ops  87989460688

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
