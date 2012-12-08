From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH 1/3] urcu: avoid "expression result unused"
 from clang
Date: Sat, 8 Dec 2012 15:54:06 +0800
Message-ID: <CACvQF514yxBjppYFKJEqX=n31LdU6dTqBg9-7kn5AoTy0i7=Lw__39680.9955047958$1354953293$gmane$org@mail.gmail.com>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<20121207165848.GB12338@Krystal>
	<CACvQF53+x_PDd+aOtM0k2wN0BJZXRMkB3pjXxfvsV=HkdknM=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f83a909f67b8f04d052a2c2
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1ThFEi-0001Jg-D1
	for lttng-dev@lists.lttng.org; Sat, 08 Dec 2012 02:54:12 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so1282474obb.35
	for <lttng-dev@lists.lttng.org>; Fri, 07 Dec 2012 23:54:06 -0800 (PST)
In-Reply-To: <CACvQF53+x_PDd+aOtM0k2wN0BJZXRMkB3pjXxfvsV=HkdknM=Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--e89a8f83a909f67b8f04d052a2c2
Content-Type: text/plain; charset=ISO-8859-1

How about the one in yy.diff?

xx.diff fixes the one what I had sent in 1/3 patch, but it may still
cause warning in future if the complier become more strict.

On Sat, Dec 8, 2012 at 1:27 AM, Lai Jiangshan <eag0628@gmail.com> wrote:
>
>
> On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
>>
>> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> > The last expression result is unused and clang will complain.
>> > The trick in the patch supresses the complaint
>>
>> Hrm, but with this patch, gcc complains:
>>
>> rculfhash.c:1921:3: warning: variable '_w' set but not used
>> [-Wunused-but-set-variable]
>>
>> using
>>
>> gcc version 4.7.2 (Debian 4.7.2-4)
>
>
> Ouch, my gcc is too old
>
>
>>
>>
>> Thoughts ?
>>
>> Thanks,
>>
>> Mathieu
>>
>> >
>> > Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
>> > ---
>> >  urcu/system.h        |    5 ++++-
>> >  2 files changed, 4 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/urcu/system.h b/urcu/system.h
>> > index 2a45f22..6b7b0af 100644
>> > --- a/urcu/system.h
>> > +++ b/urcu/system.h
>> > @@ -46,12 +46,15 @@
>> >  /*
>> >   * Store v into x, where x is located in shared memory. Performs the
>> >   * required cache flush after writing. Returns v.
>> > + * "_w" here avoids the warning from clang:
>> > + *   warning: expression result unused [-Wunused-value]
>> >   */
>> >  #define CMM_STORE_SHARED(x, v)               \
>> >       ({                              \
>> >               __typeof__(x) _v = _CMM_STORE_SHARED(x, v);     \
>> > +             __typeof__(x) _w;       \
>> >               cmm_smp_wmc();          \
>> > -             _v;                     \
>> > +             _w = _v;                \
>> >       })
>> >
>> >  #endif /* _URCU_SYSTEM_H */
>> > --
>> > 1.7.4.4
>> >
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> Operating System Efficiency R&D Consultant
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--e89a8f83a909f67b8f04d052a2c2
Content-Type: application/octet-stream; name="xx.diff"
Content-Disposition: attachment; filename="xx.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hagg1dgl0

ZGlmZiAtLWdpdCBhL3VyY3Uvc3lzdGVtLmggYi91cmN1L3N5c3RlbS5oCmluZGV4IDJhNDVmMjIu
LmZlMGVlMzAgMTAwNjQ0Ci0tLSBhL3VyY3Uvc3lzdGVtLmgKKysrIGIvdXJjdS9zeXN0ZW0uaApA
QCAtNTAsOCArNTAsOSBAQAogI2RlZmluZSBDTU1fU1RPUkVfU0hBUkVEKHgsIHYpCQlcCiAJKHsJ
CQkJXAogCQlfX3R5cGVvZl9fKHgpIF92ID0gX0NNTV9TVE9SRV9TSEFSRUQoeCwgdik7CVwKKwkJ
X190eXBlb2ZfXyh4KSBfdzsJXAogCQljbW1fc21wX3dtYygpOwkJXAotCQlfdjsJCQlcCisJCSh7
X3cgPSBfdjt9KTsJCVwKIAl9KQogCiAjZW5kaWYgLyogX1VSQ1VfU1lTVEVNX0ggKi8K
--e89a8f83a909f67b8f04d052a2c2
Content-Type: application/octet-stream; name="yy.diff"
Content-Disposition: attachment; filename="yy.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hagg1dh11

ZGlmZiAtLWdpdCBhL3VyY3Uvc3lzdGVtLmggYi91cmN1L3N5c3RlbS5oCmluZGV4IDJhNDVmMjIu
LmYyNjk1ZTIgMTAwNjQ0Ci0tLSBhL3VyY3Uvc3lzdGVtLmgKKysrIGIvdXJjdS9zeXN0ZW0uaApA
QCAtNTEsNyArNTEsNyBAQAogCSh7CQkJCVwKIAkJX190eXBlb2ZfXyh4KSBfdiA9IF9DTU1fU1RP
UkVfU0hBUkVEKHgsIHYpOwlcCiAJCWNtbV9zbXBfd21jKCk7CQlcCi0JCV92OwkJCVwKKwkJMSA/
IF92IDogKHsqKHZvbGF0aWxlIF9fdHlwZW9mX18oeCkgKilOVUxMID0gX3Y7fSk7CVwKIAl9KQog
CiAjZW5kaWYgLyogX1VSQ1VfU1lTVEVNX0ggKi8K
--e89a8f83a909f67b8f04d052a2c2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--e89a8f83a909f67b8f04d052a2c2--
