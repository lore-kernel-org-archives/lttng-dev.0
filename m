From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH RFC v2 lttng-tools] Testpoint mechanism
Date: Thu, 13 Sep 2012 16:49:39 -0400
Message-ID: <1347569380-6409-1-git-send-email-christian.babeux__19185.8549871997$1347569428$gmane$org@efficios.com>
References: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TCGMJ-0001hs-BR
	for lttng-dev@lists.lttng.org; Thu, 13 Sep 2012 16:49:59 -0400
Received: by qcsc21 with SMTP id c21so2983688qcs.35
	for <lttng-dev@lists.lttng.org>; Thu, 13 Sep 2012 13:49:53 -0700 (PDT)
In-Reply-To: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

Here a few style and minor fixes to the original testpoints patch.

Changelog v2:

- Moved dlsym call to a separate function in testpoint.c.
  This is to avoid to have to define __USE_GNU in the testpoint
  header and possibly contaminate others with this define.
- Use caa_likely/unlikely instead of defining likely/unlikely.
- Style and comments fixes.

Thanks,

Christian Babeux (1):
  New testpoint mechanism to instrument LTTng binaries for testing
    purpose

 configure.ac                     |  1 +
 src/common/Makefile.am           |  2 +-
 src/common/testpoint/Makefile.am |  6 ++++
 src/common/testpoint/testpoint.c | 69 ++++++++++++++++++++++++++++++++++++++
 src/common/testpoint/testpoint.h | 72 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 src/common/testpoint/Makefile.am
 create mode 100644 src/common/testpoint/testpoint.c
 create mode 100644 src/common/testpoint/testpoint.h

-- 
1.7.11.4
