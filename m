From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: Cross-domain influence on overhead
Date: Fri, 4 Jan 2013 11:53:59 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF5BC8AEAD__69.9235861704395$1357300496$gmane$org@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1Tr5qh-0007El-9m
	for lttng-dev@lists.lttng.org; Fri, 04 Jan 2013 06:54:07 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1Tr5qa-00015q-IM from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 04 Jan 2013 03:54:00 -0800
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

I've noticed the following somewhat puzzling effect on both Intel and ARM a=
rchitecture computers:

If all trace events are enabled in one domain only, either kernel or user s=
pace, and there are lots of static tracepoints instrumented in the other, t=
hen these inactive tracepoints start causing overhead of about the same mag=
nitude as if they were active, as if trace events were enabled in this doma=
in.

Is there any obvious explanation to this behaviour?

Cheers,

Fredrik =D6stman

http://go.mentor.com/sourceryanalyzer/
