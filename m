From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH 1/4] Introduce a new
 utils_resolve_relative function
Date: Thu, 14 Nov 2013 12:07:31 -0500
Message-ID: <CAE_Gge1=gN2K1yVQ=1gXqH3Z-NYOKWrrW807xNRjb2P6XbmppA__4349.544682964$1384448937$gmane$org@mail.gmail.com>
References: <1384320878-28808-1-git-send-email-raphael.beamonte@gmail.com>
	<20131112195134.GB12183@thessa>
	<1384320878-28808-2-git-send-email-raphael.beamonte@gmail.com>
	<254665384.67131.1384438761175.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1Vh0Oa-00012q-OU
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 12:08:02 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so2534560oag.39
	for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2013 09:07:51 -0800 (PST)
In-Reply-To: <254665384.67131.1384438761175.JavaMail.zimbra@efficios.com>
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
> We should document that this returns allocated memory which needs to be f=
reed by the caller.

Right.

> Also, we should clearly state that the only reason why we implement this =
is that realpath() only works on existing paths, which does not cover our u=
se-case of having to resolve partially unexisting paths.

... or fully unexisting paths ;)
Didn't add the comment here as it is already precised for the
utils_expand_path function that is the one made for that. This
utils_resolve_relative does not aim to replace realpath by itself, but
just take care of resolving relative paths such as "./" and "../". If
we wanted to resolve such paths but not using an absolute path as
argument, it would be useful too.
Yeah, in this very case, it is used by utils_expand_path to replace
realpath. But I think this comment is not appropriate for this
function, that would lead to miscomprehension. Perhaps the comment
about "so that it works even if the directory does not exist" isn't
appropriate either.

> I might be missing something, but how can this work on paths like this ?
>
> "./a/../b/./c/../d/./e" ?

The first while will replace the /./ strings:
- ./a/../b/c/../d/e
The second while will replace the /../ strings:
- ./b/d/e
Just tried to add it in the unit test :
- ok 10 - valid test case: ./a/../b/./c/../d/./e

Yeah, there's still the starting "./", but the starting relative paths
are not in the scope of this function, as it is stated in the
descriptive comment ("in the middle of the path"). It is thus a
working case.

> At first glance, it looks like the only cases that work correctly are tho=
se in the test case, but there are various variants that won't.

Can you give me examples ?
I can see one only case that's not working, it's when the path starts
with "../../", as the "/../" will be treated as if it is in the middle
of the string. I'll fix that and send the patch. But if you have any
other examples that would not work, I would gladly use them to verify
that the function works properly, it's sometimes difficult to think
about all the different cases to test (most of my ideas were put in
the unit test).

> One possible alternative approach to all this path mangling would be to u=
se realpath() on sections of paths (using / as separator, from the start of=
 path), until realpath() fails to lookup the final paths. Maybe then could =
we simply append the paths as is without resolving. Users would have to kno=
w that they should not put "." or ".." in the unexisting part of their path=
s. Thoughts ?

I think that it would be using many calls to realpath for some case of
"try and fail", when we can do something that directly works (one call
to realpath). That's not so many analysis to do on the developer side,
and that's a better experience on the user side. Moreover, this
function does not aim to replace realpath, that's the other one (but
yeah, the other one is using this one).

Thanks,
Rapha=EBl
