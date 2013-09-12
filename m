From: Christian Babeux <christian.babeux@efficios.com>
Subject: Running lttng-tools testsuite against an installed
	codebase
Date: Thu, 12 Sep 2013 18:29:25 -0400
Message-ID: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA__32369.7380874821$1379025027$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VKFOE-0003qP-M5
	for lttng-dev@lists.lttng.org; Thu, 12 Sep 2013 18:29:36 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so355730vbf.21
	for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2013 15:29:25 -0700 (PDT)
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

Hi lttng-testers,

The current lttng-tools testsuite has some limitations as recently
pointed out on this OpenEmbedded thread [1].

The testsuite cannot be runned against an installed codebase of
lttng-tools because the tests assume that the lttng cli and the
testapps are located in the build directory.

Perhaps an env. var. could be used when running the make installcheck target?

Any thoughts on how we could resolve this issue?

Thanks,

Christian

[1] - http://lists.openembedded.org/pipermail/openembedded-core/2013-September/084196.html
