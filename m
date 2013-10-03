From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTng UST PATCH 0/2] Bug fixes for callsite
	unregistering
Date: Thu, 3 Oct 2013 06:46:20 +0000
Message-ID: <009B25148989C6458484484699278506E538AF34__15629.8160822645$1380782832$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VRcg9-00086o-4q
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 02:46:31 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VRcg2-0007iA-Nf from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 23:46:22 -0700
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

The following two patches fix one bug each in LTTng UST.

The first patch makes sure that when a library registers callsites, those callsites are also properly unregistered.
It is only a matter of actually updating the list of callsites during registration.

The second patch deals with nested dynamic libraries. The current code disables tracepoints whenever a library destructor gets called.
But if those tracepoints are also used by some other open library, then they stop working.
The solution in the patch keeps track of how many callsites use a tracepoint, and disables the tracepoint only after the last library logs off.
To work, the first patch must be applied first.

JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer
Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
