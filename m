From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Bug in LTTng-UST
Date: Sat, 13 Dec 2014 00:54:35 +0000
Message-ID: <1418432075.9766.6.camel__23853.9499849596$1418432135$gmane$org@moya>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matthew.khouzam@ericsson.com>) id 1Xzayp-0003mM-6T
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 19:54:50 -0500
Content-Language: en-US
Content-ID: <DA05CBC2A5E1F343A47FC56D8BDA26EC@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi, it appears as though if a tracepoint is in a so, loading it,
unloading it and reloading it makes it no longer visible.

To confirm this you can try out this repo : 
https://github.com/TheMatthew/yquake2 
(I know, it's not a serious program... but the bug is serious, I think)
You can get the demo files here
http://www.fileplanet.com/6584/0/fileinfo/Quake-2-Demo-v3.14
make the program (make from the git dir)
copy the contents of the baseq2 in the demo into the release/baseq2
directory

start a ust session
run the program.
Ignore the baddr deadlocks :)
The tracepoint is not visible, it is located in the game.so file. 

Chances are though that the problem is on my side, but the evidence
(single registration ) seems to indicate that this is an actual problem.
