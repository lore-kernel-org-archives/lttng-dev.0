From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: typo 'convet' -> 'convert'
Date: Thu, 15 Nov 2018 12:16:37 -0500
Message-ID: <20181115171637.3839-2-mjeanson__16999.0159375176$1542302089$gmane$org@efficios.com>
References: <20181115171637.3839-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42wp1m2HvDzrFg
 for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2018 12:16:44 -0500 (EST)
In-Reply-To: <20181115171637.3839-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/common/lttng-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/lttng-elf.c b/src/common/lttng-elf.c
index 52e05f0c6..cb01f7bb7 100644
--- a/src/common/lttng-elf.c
+++ b/src/common/lttng-elf.c
@@ -861,7 +861,7 @@ int lttng_elf_get_symbol_offset(int fd, char *symbol, uint64_t *offset)
 	 */
 	ret = lttng_elf_convert_addr_in_text_to_offset(elf, addr, offset);
 	if (ret) {
-		DBG("Cannot convet addr to offset.");
+		DBG("Cannot convert addr to offset.");
 		goto free_string_table_data;
 	}
 
-- 
2.17.1
