From: Colin Ian King <colin.king@canonical.com>
Subject: [PATCH lttng-tools v3] Fix: syscall_table_nb_entry
 invalid value when no syscalls TPs are defined
Date: Tue, 21 Mar 2017 09:31:20 +0000
Message-ID: <6e1e4b6e-9e73-4afa-a987-bbafd19e243d__42885.5808488608$1490089731$gmane$org@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.lttng.org (Postfix) with ESMTP id 3vnSgj4c3WzwNv
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2017 09:48:49 +0000 (UTC)
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
List-Id: lttng-dev@lists.lttng.org

PmZzY2FuZiBvbiBhbiBlbXB0eSBmaWxlIHJldHVybnMgZGlyZWN0bHkgd2l0aG91dCBhc3NpZ25p
bmcgdmFsdWUgdG8KPidpbmRleCcgbGVhZGluZyB0byBhc3NpZ25pbmcgdGhlIHZhbHVlIG9mIGFu
IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUgdG8KPnN5c2NhbGxfdGFibGVfbmJfZW50cnkuIFRoaXMg
Y2FuIHJlc3VsdCBpbiBtZW1vcnkgYWxsb2NhdGlvbiBwcm9ibGVtcwo+d2hlbiBsaXN0aW5nIHN5
c2NhbGxzIG9uICdsdHRuZyBsaXN0IC0ta2VybmVsIC0tc3lzY2FsbCdbMV1bMl0uCj4KPkZpeGVz
ICMxMDkxCj4KPlsxXSBodHRwczovL2J1Z3MubHR0bmcub3JnL2lzc3Vlcy8xMDkxCj5bMl0gaHR0
cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2J1Zy8xNjcxMDYz
Lwo+Cj5TaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBSYWpvdHRlIDxqb25hdGhhbi5yYWpvdHRlLWp1
bGllbiBhdCBlZmZpY2lvcy5jb20+CgpUaGFua3MgSm9uYXRoYW4uCgpUZXN0ZWQtYnk6IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmct
ZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxt
YW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
