From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [PATCH lttng-tools] Add the formal version before
 the git version for a commit outside the master branch
Date: Mon, 4 Aug 2014 14:12:48 -0400
Message-ID: <CAE_Gge2ChC0CvO9_rUaPg75BrA1bcZAn+2kZ3wjgTjeQJ4TDxg__45574.6030704633$1407176242$gmane$org@mail.gmail.com>
References: <1406577604-2799-1-git-send-email-raphael.beamonte@gmail.com>
 <1643385577.24172.1406841466938.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nashii@gmail.com>) id 1XEMl2-0002tE-Ql
 for lttng-dev@lists.lttng.org; Mon, 04 Aug 2014 14:13:22 -0400
Received: by mail-oi0-f50.google.com with SMTP id a141so4770262oig.37
 for <lttng-dev@lists.lttng.org>; Mon, 04 Aug 2014 11:13:09 -0700 (PDT)
In-Reply-To: <1643385577.24172.1406841466938.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

2014-07-31 17:17 GMT-04:00 Mathieu Desnoyers <mathieu.desnoyers@efficios.co=
m>:
> Is this change still needed after the recent changes I did ?

No, I guess it is not. It was only to add the version number in the
version string as asked, but I guess it's not necessary anymore.

> ----- Original Message -----
>> From: "Rapha=EBl Beamonte" <raphael.beamonte@gmail.com>
>> To: lttng-dev@lists.lttng.org
>> Cc: "Rapha=EBl Beamonte" <raphael.beamonte@gmail.com>
>> Sent: Monday, July 28, 2014 4:00:04 PM
>> Subject: [lttng-dev] [PATCH lttng-tools] Add the formal version before t=
he    git version for a commit outside the
>> master branch
>>
>> Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
>> ---
>>  include/Makefile.am | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/Makefile.am b/include/Makefile.am
>> index d40cb4a..67a7063 100644
>> --- a/include/Makefile.am
>> +++ b/include/Makefile.am
>> @@ -24,8 +24,10 @@ version.h:
>>                       if [ "$${git_branch}" =3D=3D "$${git_describe}" ] =
|| \
>>                               [ "$${git_branch}" =3D=3D "heads/master" ]=
; then \
>>                               git_version=3D"$${git_describe}"; \
>> +                             addversion=3D""; \
>>                       else \
>>                               git_version=3D"$$(git describe --long --al=
l)"; \
>> +                             addversion=3D"\" VERSION \"-"; \
>>                       fi; \
>>               fi; \
>>               ##
>> @@ -46,19 +48,19 @@ version.h:
>>                       ## as the one currently in the file (if there is o=
ne), as we
>>                       ## don't want to update the file if it is already =
up to date
>>                       ##
>> -                     if [ $$(grep -cE "^#define GIT_VERSION \"?$${git_v=
ersion}\"?$$"
>> "$${version_h}") -eq 0 ]; then \
>> +                     if [ $$(grep -cE "^#define GIT_VERSION
>> \"?$${addversion}$${git_version}\"?$$" "$${version_h}") -eq 0 ]; then \
>>                               if [ $$(grep -c "^#define GIT_VERSION" "$$=
{version_h}") -gt 0 ]; then \
>>                                       ##
>>                                       ## If there is already a GIT_VERSI=
ON defined,
>>                                       ## we just replace it by the new v=
ersion
>>                                       ##
>> -                                     sed -i "s'^#define GIT_VERSION.*$$=
'#define GIT_VERSION
>> \"$${git_version}\"'" "$${version_h}"; \
>> +                                     sed -i "s'^#define GIT_VERSION.*$$=
'#define GIT_VERSION
>> \"$${addversion}$${git_version}\"'" "$${version_h}"; \
>>                               else \
>>                                       ##
>>                                       ## Else, we add a GIT_VERSION defi=
ne
>>                                       ## containing our new version.
>>                                       ##
>> -                                     sed -i "s'^\(#define VERSION_H.*\)=
$$'\1\n\n#define GIT_VERSION
>> \"$${git_version}\"'" "$${version_h}"; \
>> +                                     sed -i "s'^\(#define VERSION_H.*\)=
$$'\1\n\n#define GIT_VERSION
>> \"$${addversion}$${git_version}\"'" "$${version_h}"; \
>>                               fi; \
>>                       fi; \
>>               fi; \
>> --
>> 2.0.0.rc0
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
