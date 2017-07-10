From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RELEASE] Babeltrace 2.0.0-pre3
Date: Mon, 10 Jul 2017 15:23:29 -0400
Message-ID: <0bf97675-de46-73c6-a373-9cae88a4807a__24831.68539261$1499714790$gmane$org@efficios.com>
References: <CA+jJMxtYb2dhvgftapzicdqOVvMyPpqKrLjod66FZ4NzcK+Tuw@mail.gmail.com>
 <87van0xgbl.fsf@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------41B111712603865AD7BAC8EB"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3x5wCg5crSz13mg
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 19:25:19 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C843B34015C
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 19:24:39 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wrMIqq8Abn5Y for <lttng-dev@lists.lttng.org>;
 Mon, 10 Jul 2017 19:24:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 27280340179
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 19:24:39 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yQ1qz1oIvA_E for <lttng-dev@lists.lttng.org>;
 Mon, 10 Jul 2017 19:24:39 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id 0A4C334015C
 for <lttng-dev@lists.lttng.org>; Mon, 10 Jul 2017 19:24:39 +0000 (UTC)
In-Reply-To: <87van0xgbl.fsf@mentor.com>
Content-Language: en-CA
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

This is a multi-part message in MIME format.
--------------41B111712603865AD7BAC8EB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-10 15:06, Nathan Lynch wrote:
>=20
> (This is with master hence the -pre1 reported, but the code is the same=
.)
>=20
> I get failures when building with BUILT_IN_PLUGINS as suggested here:
>=20
> https://lists.lttng.org/pipermail/lttng-dev/2017-June/027243.html
>=20
> Is BUILT_IN_PLUGINS intended to accomplish something that libtool canno=
t?
>=20
> $ ./configure --quiet --disable-shared BUILT_IN_PLUGINS=3D1
> Babeltrace 2.0.0-pre1
>=20
> System
>   Target architecture:                x86_64
>=20
> Python 3 language support
>   Python bindings:                    no
>   Python plugin support:              no
>=20
> Plugins
>   'ctf' plugin:                       yes
>   'lttng-utils' plugin:               yes
>   'text' plugin:                      yes
>   'utils' plugin:                     yes
>=20
> Built-in features
>   Built-in plugins:                   yes
>   Built-in Python plugin support:     no
>=20
> Documentation
>   HTML API documentation:             no
>   Python bindings documentation:      no
>=20
> Logging
>   Minimal log level:                  VERBOSE
>=20
> Testing
>   Python bindings tests:              no
>=20
> Install directories
>   Binaries:                           /usr/local/bin
>   Libraries:                          /usr/local/lib
>   Plugins:                            /usr/local/lib/babeltrace/plugins
>   Configuration:                      /usr/local/etc
> $ make
> ....
> Making all in cli
>   CCLD     babeltrace.bin
> /usr/bin/ld: cannot find /home/nathanl/src/babeltrace/plugins/ctf/.libs=
/libbabeltrace-plugin-ctf.a: No such file or directory
> /usr/bin/ld: cannot find /home/nathanl/src/babeltrace/plugins/text/.lib=
s/libbabeltrace-plugin-text.a: No such file or directory
> /usr/bin/ld: cannot find /home/nathanl/src/babeltrace/plugins/utils/.li=
bs/libbabeltrace-plugin-utils.a: No such file or directory
> /usr/bin/ld: cannot find /home/nathanl/src/babeltrace/plugins/lttng-uti=
ls/.libs/libbabeltrace-plugin-lttng-utils.a: No such file or directory
> collect2: error: ld returned 1 exit status
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20

Hi Nathan,

This one is my fault, I forgot to stage one file when I submitted
22e7ae1917a72d89b308345b3bcb97c76362da4f. J=C3=A9r=C3=A9mie is on vacatio=
n for the
week, in the meantime you can apply the attached patch.

Cheers,

Michael


--------------41B111712603865AD7BAC8EB
Content-Type: text/x-patch;
 name="0001-Fix-built-in-plugins-with-new-plugin-filenames.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-built-in-plugins-with-new-plugin-filenames.patch"

From 22949ce66d5da98cd8251e3fc54b0583847a1550 Mon Sep 17 00:00:00 2001
From: Michael Jeanson <mjeanson@efficios.com>
Date: Mon, 10 Jul 2017 15:22:39 -0400
Subject: [PATCH babeltrace stable-1.5] Fix: built-in plugins with new plugin
 filenames

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 cli/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cli/Makefile.am b/cli/Makefile.am
index 902ad0d..5ceb499 100644
--- a/cli/Makefile.am
+++ b/cli/Makefile.am
@@ -64,7 +64,7 @@ if BUILT_IN_PLUGINS
 # binary that are filled by plugin objects. If the linker discards those
 # symbols because the CLI does not use them directly, the CLI reports
 # no plugins found (plugins are effectively not embedded).
-pluginarchive = -Wl,--whole-archive,$(PLUGINS_PATH)/$(1)/.libs/libbabeltrace-plugin-$(1).a,--no-whole-archive
+pluginarchive = -Wl,--whole-archive,$(PLUGINS_PATH)/$(1)/.libs/babeltrace-plugin-$(1).a,--no-whole-archive
 
 # Built-in plugins
 babeltrace_bin_LDFLAGS += $(call pluginarchive,ctf)
-- 
2.7.4


--------------41B111712603865AD7BAC8EB
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--------------41B111712603865AD7BAC8EB--
