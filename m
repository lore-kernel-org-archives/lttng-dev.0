From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: When is tracepoint registration finished?
Date: Fri, 13 Jul 2012 10:29:31 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF56CB1DF1__14487.1008735665$1342175406$gmane$org@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1Spd80-00067V-ER
	for lttng-dev@lists.lttng.org; Fri, 13 Jul 2012 06:29:40 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1Spd7t-0000J3-S5 from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 13 Jul 2012 03:29:33 -0700
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

Is there any way to know from within the instrumented application when trac=
epoint registration is finished?

We have instrumented clib functions, which are used by LTTng and start prod=
ucing trace events before all tracepoint registration is finished. On ARM, =
this messes up LTTng UST and faulty events are recorded. On all architectur=
es, we trace function calls we aren't interested in.

Cheers,

Fredrik =D6stman
