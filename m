From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH] Fix: XML declaration must be at beginning of
	XSD file
Date: Thu, 10 Apr 2014 17:16:39 -0400
Message-ID: <1397164599-28503-1-git-send-email-christian.babeux__14455.7610074573$1397164727$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1WYMLr-0004BX-TI
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 17:17:45 -0400
Received: by mail-ve0-f175.google.com with SMTP id oz11so3905752veb.6
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 14:17:34 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TW92ZSBkb3duIGxpY2Vuc2UgaW5mb3JtYXRpb24gdG8gZml4IHRoZSBwYXJzZXIgZXJyb3IgOgpY
TUwgZGVjbGFyYXRpb24gYWxsb3dlZCBvbmx5IGF0IHRoZSBzdGFydCBvZiB0aGUgZG9jdW1lbnQK
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBCYWJldXggPGNocmlzdGlhbi5iYWJldXhAZWZmaWNp
b3MuY29tPgotLS0KIHNyYy9jb21tb24vY29uZmlnL3Nlc3Npb24ueHNkIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L2NvbW1vbi9jb25maWcvc2Vzc2lvbi54c2QgYi9zcmMvY29tbW9uL2NvbmZpZy9zZXNzaW9uLnhz
ZAppbmRleCA5MTBmMDcwLi43YzNlOWQ4IDEwMDY0NAotLS0gYS9zcmMvY29tbW9uL2NvbmZpZy9z
ZXNzaW9uLnhzZAorKysgYi9zcmMvY29tbW9uL2NvbmZpZy9zZXNzaW9uLnhzZApAQCAtMSwzICsx
LDQgQEAKKzw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9IlVURi04Ij8+CiA8IS0tCiBDb3B5
cmlnaHQgKGMpIDIwMTQgLSBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBl
ZmZpY2lvcy5jb20+CiAKQEAgLTE5LDcgKzIwLDYgQEAgTElBQklMSVRZLCBXSEVUSEVSIElOIEFO
IEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsIEFSSVNJTkcgRlJPTSwKIE9V
VCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RI
RVIgREVBTElOR1MgSU4KIFRIRSBTT0ZUV0FSRS4KIC0tPgotPD94bWwgdmVyc2lvbj0iMS4wIiBl
bmNvZGluZz0iVVRGLTgiPz4KIDx4czpzY2hlbWEgeG1sbnM6eHM9Imh0dHA6Ly93d3cudzMub3Jn
LzIwMDEvWE1MU2NoZW1hIgogZWxlbWVudEZvcm1EZWZhdWx0PSJxdWFsaWZpZWQiIHZlcnNpb249
IjIuNSI+CiAKLS0gCjEuOC41LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
