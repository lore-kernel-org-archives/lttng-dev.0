From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTNG-UST PATCH 00/01] Added event exclusion
Date: Mon, 26 Aug 2013 12:52:32 +0000
Message-ID: <009B25148989C6458484484699278506E53869B7__48080.5801730186$1377521611$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VDwHh-0000e3-GQ
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 08:52:45 -0400
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
Cc: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This patch adds the possibility to NOT enable given events, even if they are covered by some wildcard specification.
When an event specification in the enable-event command starts with a '!' character, the specification is taken to tell which events should never be enabled.

Thus, the commands

lttng event-enable -u -s test -c testc "!ab*"
lttng event-enable -u -s test -c testc "a*"

will enable all events that begin with 'a', unless they begin with 'ab'.

On a related LTTng-tools patch, a new option --exclude (or -x) is added to the event-enable command.
This option just prepends the '!' character to the given event, and ignores all loglevel and filter options.
This, you can say
lttng event-enable -u -s test -c testc "a*" --exclude "ab*"
on one single command line.

For an extended discussion, see http://lists.lttng.org/pipermail/lttng-dev/2013-August/021181.html


JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
