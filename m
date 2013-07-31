From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
	realloc.
Date: Tue, 30 Jul 2013 22:14:02 -0400
Message-ID: <CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ__38822.724906686$1375236902$gmane$org@mail.gmail.com>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V4LvU-0006Fu-Ao
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 22:14:12 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so3353876wib.4
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 19:14:02 -0700 (PDT)
In-Reply-To: <51F82C45.6020502@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Tue, Jul 30, 2013 at 5:12 PM, Stefan Seefeld
<stefan_seefeld@mentor.com> wrote:
> Hi J=E9r=E9mie,
>
> thanks for the quick review. I agree with the fragility of the calloc()
> hack. However, we aren't the only ones hitting this circular dependency
> (as google confirms).
> Some more investigation reveals that dlsym() is in fact prepared for
> calloc() to return NULL (in which case an internal static buffer is
> used. And yes, it appears to check for that case during cleanup.)
>
> Thus I have updated the patch, addressing all of the issues you raise,
> and replaced the "dummy_malloc" business by a simple dummy_calloc()
> returning NULL. This appears to be working fine.
>

I have no doubt it works fine with a simple program, but this comment
in glibc/dlfcn/dlerror.c:143 worries me:

/* ... call to calloc ... */
if (result =3D=3D NULL) {
/* We are out of memory.  Since this is no really critical
   situation we carry on by using the global variable.
   This might lead to conflicts between the threads but
   they soon all will have memory problems. */

> Meanwhile, I'd like to understand your suggestion, so let me follow up
> on that, too:
>
> On 07/29/2013 07:19 PM, J=E9r=E9mie Galarneau wrote:
>
>> I may be missing something, but since this structure is allocated only
>> once per thread, subsequent calls from the same thread to dlsym()
>> should not result in another call to calloc(). That should make it
>> possible to call malloc() in dummy_calloc() without causing the
>> recursion.
>
> You are right. But the problem is that, if I call malloc() in
> dummy_calloc(), I indirectly end up calling dlsym() from within dlsym()...
>

You're right. I was thinking __dlerror_run() would have initialized
its dl_action_result structure by the point dlsym() was called a
second time... but it's not the case, hence the recursion... Oops!

>> Perhaps we could also forego this mechanism completely and initialize
>> the symbols from a constructor since this library is meant to be
>> LD_PRELOAD-ed?
>
> I don't quite understand what you are suggesting. dlsym() still calls
> calloc(), so our wrapper still needs to check whether initialization has
> already been completed, and if not, use a fallback.
>
> The code may be reorganized, but that doesn't seem to make it any simpler.
>

Indeed, I was basing this on the same false assumption.

The only other solution I can propose is calling __libc_calloc, which
is exported by glibc, instead of using dlsym to find calloc(). That
somehow appears cleaner to me, but I'm not sure how to handle building
against other implementations of libc...

Anyway, Mathieu will undoubtedly have a strong opinion on this matter ;-)
You may want to wait until he steps-in before continuing to work on this pa=
tch.

Regards,
J=E9r=E9mie

> Regards,
>         Stefan
>
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
