From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH 3/4] Correct the behavior of the
 utils_expand_path function
Date: Thu, 14 Nov 2013 11:00:12 -0500
Message-ID: <CAE_Gge30J9GEssQoKSO-KL=gm22HRhfCXJXFBorqYSHekEfVqQ__25547.2443918281$1384444905$gmane$org@mail.gmail.com>
References: <1384320878-28808-1-git-send-email-raphael.beamonte@gmail.com>
	<20131112195134.GB12183@thessa>
	<1384320878-28808-4-git-send-email-raphael.beamonte@gmail.com>
	<722861522.67118.1384438214771.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1VgzLU-0006Jd-70
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 11:00:46 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so2234358wgg.9
	for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2013 08:00:34 -0800 (PST)
In-Reply-To: <722861522.67118.1384438214771.JavaMail.zimbra@efficios.com>
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

2013/11/14 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>:
> Comments should start with a:
>
>  /*
>   * Then start of comment...

Right. Should I submit a new patch for that ?

> There is no point in ending a "" with \0, it implicitly ends with a \0 al=
ready.
>
>> +                             strncmp(end_path, ".\0", 2) =3D=3D 0) {
>
> Same here.

Was done like that for clarity, as "implicit" is not "clear". Would it
be preferable to hide it but still compare the first 2 chars of a 1
char string ? (respectively 3 chars of a 2 chars string)

> Not necessarily. What happens in the unlikely case someone passes a path =
with simply "/" ?

Then we're not in this arm of the "if". If the path starts by (or is)
'/', it is considered as a "absolute path", and we're just in the arm
of the "if" that starts with the comment "/* If given path is already
absolute */"

> So let's say we have:
>
> "../blah/../blah"
>
> so only "../" passed to realpath, or the entire "../blah/../blah" ? (let'=
s suppose blah/ exists), right ?

Perhaps "blah/" exists, perhaps "blah/" doesn't exist. In both cases,
it should not matter for our function. As we don't have any easy way
to know that directly, we are not considering it for the realpath
call, but only the "relative paths" that we can evaluate ("./" or
"../").
You can look at the loop that starts with the comment "/* Split part
that will be resolved by realpath", and see that in this case, only
"../" will be passed to realpath.

> In the "../blah/../blah" case, here the other ../ would be dealt with by =
utils_resolve_relative, is that it ?

Exactly, as we can't pass it to realpath in case the directory does not exi=
st.

Rapha=EBl
