From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: ust libc and fork wrapper question
Date: Wed, 28 Aug 2013 14:05:03 -0400
Message-ID: <521E3BCF.5060500__39813.8114637279$1377713204$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VEk7m-0003lU-3X
	for lttng-dev@lists.lttng.org; Wed, 28 Aug 2013 14:05:51 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello tracing sages,

I was trying out the libc wrapper in ust. It works very well but does
not follow forks. (to be expected)

So I copied "liblttng-ust-fork.so" into my .libs directory along with
"liblttng-libc-wrapper.so".

I then run

$lttng create thing
$lttng enable-channel chan --buffer-uid
$lttng enable-event -a -k
$lttng start
$LD_PRELOAD="liblttng-ust-fork.so liblttng-libc-wrapper.so" firefox
$lttng stop
$lttng destroy

Aaaaaaaaaaand my trace has no events!

I am certain I am doing something wrong, any suggestions?

Matthew
