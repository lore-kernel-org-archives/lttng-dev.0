From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: LTTng-UST 2.0 mutex usage
Date: Mon, 9 Jul 2012 12:00:46 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF2834A6E5__12198.5044134364$1341835278$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1SoCe7-0005RN-5m
	for lttng-dev@lists.lttng.org; Mon, 09 Jul 2012 08:00:55 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1SoCe0-0000Nh-BF from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 09 Jul 2012 05:00:48 -0700
Content-Language: en-US
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

Hi,


We're experimenting with tracing calls to the pthreads library using a LD_P=
RELOAD-ed interposer library, which is instrumented with UST tracepoints. I=
n the startup phase, before the application has been called, probes are bei=
ng registered, and one by one the tracepoints start emitting events. So som=
e of the pthreads mutex motions of UST itself are being traced along.

What would be a good way of avoiding emitting events before the application=
 itself has started, specifically events related to UST mutexes? The ust-ct=
l library appears to have a function ustctl_register_done(), is that useful=
? (Is there an API documentation?) Or would it be better to find out which =
mutexes belong to UST and filter them out?

By controlling our interposer library from within the application we can av=
oid the problem, but we'd rather do without recompiling the application, si=
nce it sort of would defeat the reason for using LD_PRELOAD in the first pl=
ace.


Cheers,

Fredrik =D6stman
