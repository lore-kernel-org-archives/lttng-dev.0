From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: How to disable an event that's been enabled by a
 wildcard selection or -a?
Date: Fri, 8 Feb 2013 09:25:31 +0000
Message-ID: <009B25148989C6458484484699278506985C0CFA__45671.9063608491$1360315584$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1U3kDC-00008u-72
	for lttng-dev@lists.lttng.org; Fri, 08 Feb 2013 04:25:38 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1U3kD6-0005lw-IP from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 08 Feb 2013 01:25:32 -0800
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

Consider the following scenario.
I want to write a script that traces all UST tracepoints of a given application. I have no idea what the names of these tracepoints are. Also, I know that the application uses a library that contains some tracepoints I am not interested about. Now I want to trace all UST tracepoints except the ones I already know about. Is this possible with the lttng commands?

If I enable all tracepoints with "lttng enable-event -u -a" I get all events, even those I do not want. I've tried using "lttng disable-event", and "lttng enable-event" with a filter, but I cannot seem to be able to get rid of the specific events.

Thank you,

JP Ikaheimonen
Mentor Graphics Embedded Systems Division
Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
