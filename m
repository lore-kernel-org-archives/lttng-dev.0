From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH RFC v3 lttng-tools] Testpoint mechanism
Date: Fri, 14 Sep 2012 15:00:29 -0400
Message-ID: <1347649230-21489-1-git-send-email-christian.babeux__3710.80870177156$1347649277$gmane$org@efficios.com>
References: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TCb8B-0003NS-Ei
	for lttng-dev@lists.lttng.org; Fri, 14 Sep 2012 15:00:47 -0400
Received: by qafk30 with SMTP id k30so151908qaf.14
	for <lttng-dev@lists.lttng.org>; Fri, 14 Sep 2012 12:00:41 -0700 (PDT)
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

Here a few style and a define fix to the original testpoints patch.

Changelog v3:
- Use _GNU_SOURCE instead of __USE_GNU define. __USE_GNU is
  resetted by any headers that include features.h. This can cause
  erratic behavior depending on the order of headers inclusion.
- Style fixes.

Changelog v2:

- Moved dlsym call to a separate function in testpoint.c.
  This is to avoid to have to define __USE_GNU in the testpoint
  header and possibly contaminate others with this define.
- Use caa_likely/unlikely instead of defining likely/unlikely.
- Style and comments fixes.

Christian Babeux (1):
  New testpoint mechanism to instrument LTTng binaries for testing
    purpose

 configure.ac                     |  1 +
 src/common/Makefile.am           |  2 +-
 src/common/testpoint/Makefile.am |  6 ++++
 src/common/testpoint/testpoint.c | 64 ++++++++++++++++++++++++++++++++++
 src/common/testpoint/testpoint.h | 74 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 src/common/testpoint/Makefile.am
 create mode 100644 src/common/testpoint/testpoint.c
 create mode 100644 src/common/testpoint/testpoint.h

-- 
1.7.11.4
