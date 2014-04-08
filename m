From: "Yann E. MORIN" <yann.morin.1998-GANU6spQydw@public.gmane.org>
Subject: Re: [lttng-dev] [PATCH 1/1] Disable liblttng-ust-dl if
 dlinfo is not available in C library.
Date: Tue, 8 Apr 2014 19:24:42 +0200
Message-ID: <20140408172442.GB3199@free.fr>
References: <1396818161-20204-1-git-send-email-romain.naour@openwide.fr>
 <794709247.8287.1396903345152.JavaMail.zimbra@efficios.com>
 <53430E92.9060401@openwide.fr>
 <CAFXXi0kAZJDD7ygqs493ZPvJHMpkeuMTDvxHqMg9B722pJHHxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <buildroot-bounces-9GAsQqxh4YTR7s880joybQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFXXi0kAZJDD7ygqs493ZPvJHMpkeuMTDvxHqMg9B722pJHHxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.busybox.net/mailman/options/buildroot>,
 <mailto:buildroot-request-9GAsQqxh4YTR7s880joybQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.busybox.net/pipermail/buildroot>
List-Post: <mailto:buildroot-9GAsQqxh4YTR7s880joybQ@public.gmane.org>
List-Help: <mailto:buildroot-request-9GAsQqxh4YTR7s880joybQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.busybox.net/mailman/listinfo/buildroot>,
 <mailto:buildroot-request-9GAsQqxh4YTR7s880joybQ@public.gmane.org?subject=subscribe>
Errors-To: buildroot-bounces-9GAsQqxh4YTR7s880joybQ@public.gmane.org
Sender: buildroot-bounces-9GAsQqxh4YTR7s880joybQ@public.gmane.org
To: Simon Marchi <simon.marchi-scC8bbJcJLCw5LPnMra/2Q@public.gmane.org>
Cc: buildroot <buildroot-9GAsQqxh4YTR7s880joybQ@public.gmane.org>, "lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org" <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Simon, All,

On 2014-04-08 13:03 -0400, Simon Marchi spake thusly:
> Hi Romain,
> 
> It seems like with that commit, dlinfo is not found even on a glibc
> based system, where it is present.
> 
> See https://bugs.lttng.org/issues/778
> 
> Do you have a suggestion to fix that ?

I think we should use AC_CHECK_DECL instead of AC_CHECK_FUNCS.

dlinfo is in dlfcn.h so we need a check that allows us to include that
header, and we must check for that header first, of course. So, maybe
something like (completely untested, directly written in the mail):

    AC_CHECK_HEADER([dlfcn.h])
    AS_IF([test "${ac_cv_header_dlfcn_h}" = "yes"],
          [AC_CHECK_DECL([dlinfo],,,[dlfcn.h])],
          [ac_cv_have_decl_dlinfo="no"])
    AM_CONDITIONAL([HAVE_DLINFO], [test "${ac_cv_have_decl_dlinfo}" = "yes"])

But I'm no expert in autoconf, so the actual solution may be slightly
different.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 223 225 172 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
