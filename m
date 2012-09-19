From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: Clock correlation
Date: Wed, 19 Sep 2012 10:52:58 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF5BC6C751__26687.3203720481$1348052061$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1TEHty-0005WL-NE
	for lttng-dev@lists.lttng.org; Wed, 19 Sep 2012 06:53:06 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TEHts-000782-Ie from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 19 Sep 2012 03:53:00 -0700
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


We have a problem with kernel and ust traces not correlating in time when t=
he option --clock-raw is used. We have used babeltrace 1.0.0-rc1. I have no=
ticed that version 1.0.0-rc5 doesn't have this option at all anymore. Why n=
ot? Did anything change in the way timestamps and/or time offsets are gener=
ated in later versions of the kernel and/or user-space tracers? The traces =
were made with lttng-modules 2.0.3 and lttng-ust 2.0.5.


Cheers,

Fredrik =D6stman

http://go.mentor.com/sourceryanalyzer/
