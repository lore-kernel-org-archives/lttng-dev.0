From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace ] New option for specifiying time stamp
 offsets in nanoseconds
Date: Fri, 12 Apr 2013 05:50:07 +0000
Message-ID: <009B25148989C6458484484699278506E5371E1A__43950.0570683323$1365745853$gmane$org@EU-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UQWsJ-0007Mb-Pf
	for lttng-dev@lists.lttng.org; Fri, 12 Apr 2013 01:50:15 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1UQWsD-0001CA-Ji from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 22:50:09 -0700
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

in our work we are synchronizing traces from several sources.
For that purpose, we found that we need to set a nanosecond-resolution offset to make the traces compatible.

Babeltrace has an option --clock-offset that can add a value for each timestamp.
However, that option only accepts full seconds.

We've added a new option --clock-offset-ns which allows the user to give a new offset, this time in nanoseconds.
A patch with the implementation will follow.

Thank you,

JP Ikaheimonen | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
