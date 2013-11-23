From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [PATCH] checkpatch: change status of warning from
 "BRACES" to "BRACES_SINGLE_STMT"
Date: Sat, 23 Nov 2013 17:38:03 -0500
Message-ID: <CAE_Gge0CXpSTHRGtrw0MVRsZDdzh11fmEZUQuOmTNurPi5ivOQ__40050.5350241021$1385246678$gmane$org@mail.gmail.com>
References: <1384321468-29220-1-git-send-email-raphael.beamonte@gmail.com>
	<CAGDH53=vS-+mfjsJo8HFNGYsi+UbYgJDNZqd7bxQAYMpJhPf-w@mail.gmail.com>
	<CAE_Gge0wR7L6_SqP6YkWGiHK-Q3o-w=CR9oN9u86+wrgUxmxwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1VkLqP-0007KI-4p
	for lttng-dev@lists.lttng.org; Sat, 23 Nov 2013 17:38:35 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so2805778obb.3
	for <lttng-dev@lists.lttng.org>; Sat, 23 Nov 2013 14:38:23 -0800 (PST)
In-Reply-To: <CAE_Gge0wR7L6_SqP6YkWGiHK-Q3o-w=CR9oN9u86+wrgUxmxwQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

Do you have some follow-up on this patch ?

Thanks,
Rapha=EBl

2013/11/13 Rapha=EBl Beamonte <raphael.beamonte@gmail.com>:
> Hello Christian,
>
> You can try to use checkpatch on the patch I sent yesterday about the
> expand_path unit test. You'll see that it shows a warning for the
> following lines :
>
> +               if (strcmp(valid_tests_inputs[i].
> relative_part, ".") =3D=3D 0) {
> +                       relative =3D cur_path;
> +               } else if (strcmp(valid_tests_inputs[i].relative_part,
> "..") =3D=3D 0) {
> +                       relative =3D prev_path;
> +               } else if (strcmp(valid_tests_inputs[i].relative_part,
> "../..") =3D=3D 0) {
> +                       relative =3D pprev_path;
> +               } else {
> +                       relative =3D empty;
> +               }
>
> As I understood from a discussion with Julien, singles braces are
> recommended for LTTng source code to limit the number of modified
> lines in case of change. In this very case, the warning that is shown
> is not the one about "single statement", but the one about "braces
> [that] are not necessary for any arm of this statement".
> It seems that the single statement check you patched is only about
> single ifs. If we use else or else-if, that's not the same check that
> is used.
>
> Thanks,
> Rapha=EBl
>
>
>
> 2013/11/13 Christian Babeux <christian.babeux@efficios.com>:
>> Hi Rapha=EBl,
>>
>> Do you have a specific example that is failing for this case of braces
>> detection? I patched checkpatch a while ago in a similar way for
>> braces around single statement blocks, I don't remember the intention
>> behind the particular check you are patching.
>>
>> Thanks,
>>
>> Christian
>>
>> On Wed, Nov 13, 2013 at 12:44 AM, Rapha=EBl Beamonte
>> <raphael.beamonte@gmail.com> wrote:
>>> The warning about braces that are not necessary for any arm of a statem=
ent
>>> should be interpreted as a warning about braces around single statement=
s.
>>>
>>> Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
>>> ---
>>>  extras/checkpatch.pl |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/extras/checkpatch.pl b/extras/checkpatch.pl
>>> index fdd8484..5a67704 100755
>>> --- a/extras/checkpatch.pl
>>> +++ b/extras/checkpatch.pl
>>> @@ -3138,7 +3138,7 @@ sub process {
>>>                                                 $sum_allowed +=3D $_;
>>>                                         }
>>>                                         if ($sum_allowed =3D=3D 0) {
>>> -                                               WARN("BRACES",
>>> +                                               WARN("BRACES_SINGLE_STM=
T",
>>>                                                      "braces {} are not=
 necessary for any arm of this statement\n" . $herectx);
>>>                                         } elsif ($sum_allowed !=3D $all=
ow &&
>>>                                                  $seen !=3D $allow) {
>>> --
>>> 1.7.10.4
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
