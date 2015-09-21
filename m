From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-ust] Clean-up: remove extraneous "found"
	parameters in ust-elf
Date: Mon, 21 Sep 2015 14:19:43 -0400
Message-ID: <1442859583-9617-1-git-send-email-abusque__7544.95083024285$1442859683$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1Ze5h0-0001sa-8f
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 14:20:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2A7A8340312
 for <lttng-dev@lists.lttng.org>; Mon, 21 Sep 2015 18:19:51 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

In lttng-ust-elf.c, static functions used to extract build ID or debug
link information had an extraneous `found` parameter, carrying no more
information than could be obtained by checking the other out
parameters against NULL. The resulting simplified logic should also
prevent static analysis tools from misidentifying resource leaks.

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 liblttng-ust/lttng-ust-elf.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/liblttng-ust/lttng-ust-elf.c b/liblttng-ust/lttng-ust-elf.c
index 4de380c..dcae966 100644
--- a/liblttng-ust/lttng-ust-elf.c
+++ b/liblttng-ust/lttng-ust-elf.c
@@ -405,11 +405,10 @@ error:
 static
 int lttng_ust_elf_get_build_id_from_segment(
 	struct lttng_ust_elf *elf, uint8_t **build_id, size_t *length,
-	off_t offset, off_t segment_end, int *found)
+	off_t offset, off_t segment_end)
 {
 	uint8_t *_build_id = NULL;	/* Silence old gcc warning. */
 	size_t _length = 0;		/* Silence old gcc warning. */
-	int _found = 0;
 
 	while (offset < segment_end) {
 		struct lttng_ust_elf_nhdr nhdr;
@@ -466,16 +465,14 @@ int lttng_ust_elf_get_build_id_from_segment(
 			goto error;
 		}
 
-		_found = 1;
 		break;
 	}
 
-	if (_found) {
+	if (_build_id) {
 		*build_id = _build_id;
 		*length = _length;
 	}
 
-	*found = _found;
 	return 0;
 error:
 	free(_build_id);
@@ -501,7 +498,6 @@ int lttng_ust_elf_get_build_id(struct lttng_ust_elf *elf, uint8_t **build_id,
 	uint16_t i;
 	uint8_t *_build_id = NULL;	/* Silence old gcc warning. */
 	size_t _length = 0;		/* Silence old gcc warning. */
-	int _found = 0;
 
 	if (!elf || !build_id || !length || !found) {
 		goto error;
@@ -525,24 +521,25 @@ int lttng_ust_elf_get_build_id(struct lttng_ust_elf *elf, uint8_t **build_id,
 		offset = phdr->p_offset;
 		segment_end = offset + phdr->p_filesz;
 		ret = lttng_ust_elf_get_build_id_from_segment(
-			elf, &_build_id, &_length, offset, segment_end,
-			&_found);
+			elf, &_build_id, &_length, offset, segment_end);
 	next_loop:
 		free(phdr);
 		if (ret) {
 			goto error;
 		}
-		if (_found) {
+		if (_build_id) {
 			break;
 		}
 	}
 
-	if (_found) {
+	if (_build_id) {
 		*build_id = _build_id;
 		*length = _length;
+		*found = 1;
+	} else {
+		*found = 0;
 	}
 
-	*found = _found;
 	return 0;
 error:
 	free(_build_id);
@@ -561,16 +558,14 @@ error:
  */
 int lttng_ust_elf_get_debug_link_from_section(struct lttng_ust_elf *elf,
 					char **filename, uint32_t *crc,
-					int *found,
 					struct lttng_ust_elf_shdr *shdr)
 {
-	int _found = 0;
 	char *_filename = NULL;		/* Silence old gcc warning. */
 	size_t filename_len;
 	char *section_name = NULL;
 	uint32_t _crc = 0;		/* Silence old gcc warning. */
 
-	if (!elf || !filename || !crc || !found || !shdr) {
+	if (!elf || !filename || !crc || !shdr) {
 		goto error;
 	}
 
@@ -613,15 +608,12 @@ int lttng_ust_elf_get_debug_link_from_section(struct lttng_ust_elf *elf,
 		_crc = bswap_32(_crc);
 	}
 
-	_found = 1;
-
 end:
 	free(section_name);
-	if (_found) {
+	if (_filename) {
 		*filename = _filename;
 		*crc = _crc;
 	}
-	*found = _found;
 
 	return 0;
 
@@ -646,7 +638,6 @@ int lttng_ust_elf_get_debug_link(struct lttng_ust_elf *elf, char **filename,
 {
 	int ret;
 	uint16_t i;
-	int _found = 0;
 	char *_filename = NULL;		/* Silence old gcc warning. */
 	uint32_t _crc = 0;		/* Silence old gcc warning. */
 
@@ -663,24 +654,27 @@ int lttng_ust_elf_get_debug_link(struct lttng_ust_elf *elf, char **filename,
 		}
 
 		ret = lttng_ust_elf_get_debug_link_from_section(
-			elf, &_filename, &_crc, &_found, shdr);
+			elf, &_filename, &_crc, shdr);
 		free(shdr);
 
 		if (ret) {
 			goto error;
 		}
-		if (_found) {
+		if (_filename) {
 			break;
 		}
 	}
 
-	if (_found) {
+	if (_filename) {
 		*filename = _filename;
 		*crc = _crc;
+		*found = 1;
+	} else {
+		*found = 0;
 	}
 
-	*found = _found;
 	return 0;
+
 error:
 	free(_filename);
 	return -1;
-- 
2.5.3
