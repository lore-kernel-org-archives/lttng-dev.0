From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Exclusion event support patches
Date: Fri, 27 Sep 2013 07:14:24 +0000
Message-ID: <009B25148989C6458484484699278506E538A662__40988.8459406376$1380266131$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VPSG2-0002JD-UQ
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 03:14:41 -0400
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

The following set of four patches implement the exclusion event feature.

When you give exceptions to a wildcarded UST tracepoint event, as in 

lttng -c tc -u 'a*' --exclude 'ac*,ad*'

this enables all those events beginning with 'a' that do not begin with 'ac' or 'ad'.

The exclusions are embedded into the event name so that internally, the event name will be

'a*ac*,ad*'

This new scheme of the event name string is parsed and handled wherever necessary. This implementation poses new restrictions to event names:
1) An event name must not contain the character '*'.
2) An event name can contain a ',' character, but you cannot use it in the exclusion specification.
3) If you use exclusions, the lengths of their names count against the total maximum allowed length of the event name.

For lttng-ust, the main relevant change is where the event names are matched with enabler names. This is one patch.
For lttng-tools, there are three patches that take care of the disable-event, enable-event, and list commands, respectively.

JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer
Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
