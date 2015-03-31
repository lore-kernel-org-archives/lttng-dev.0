From: "Wolfgang Rostek" <wolfgang.rostek@gmx.de>
Subject: major variations in perfomance figures
Date: Tue, 31 Mar 2015 21:46:09 +0200
Message-ID: <trinity-1e9921b3-666b-4656-bcb8-a2125944698f-1427831168919__14609.262152999$1427831252$gmane$org@3capp-gmx-bs39>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.18])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wolfgang.rostek@gmx.de>) id 1Yd275-0000KZ-4c
 for lttng-dev@lists.lttng.org; Tue, 31 Mar 2015 15:46:20 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

I did a first perfomance test extending the demo example
by tracing 30 simple integers in a loop.

For a similar CPU (i5 quad core 2.8GHz) I saw values
mentioned around 250ns in the forum.

I've tried the test several time and could come down
to about 350ns. The machine was almost idle for all
tests.

What makes me wonder is a large variation with frequent
runs giving me 750-800ns.

Not the absolute time but the variations isn't clear
to me. From my understanding the caller path is more
or less straight to shared memory. Why do different
runs show more than double the time for the traces?

Wolfgang R.
