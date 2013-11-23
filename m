From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PULL REQUEST babeltrace] Python bindings API
	refactoring
Date: Fri, 22 Nov 2013 22:29:04 -0500
Message-ID: <CAFXXi0kr4MnZCzOGWMrUUSstCRT18XJzva=qfBLjoNEv8m8U8g__2860.48880448124$1385177432$gmane$org@mail.gmail.com>
References: <CA+jJMxuaWjcJ7M55TpX=xG00R-VQdm0e0WtMg9M-AxnBQtwGfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1Vk3ue-0001AV-4h
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 22:29:41 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so3495424iec.41
	for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2013 19:29:34 -0800 (PST)
In-Reply-To: <CA+jJMxuaWjcJ7M55TpX=xG00R-VQdm0e0WtMg9M-AxnBQtwGfg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I'm getting this error when making in bindings/python:

sed "s/BABELTRACE_VERSION_STR/Babeltrace 1.1.1/g" <babeltrace.i.in >babeltr=
ace.i
/usr/bin/swig -python -Wall -I. -I../../include babeltrace.i
babeltrace.i:367: Error: Syntax error in input(1).
make: *** [babeltrace_wrap.c] Error 1

Are you missing a little %pythoncode %{ around class ClockType ?
https://github.com/jgalar/babeltrace/blob/bindings/python/bindings/python/b=
abeltrace.i.in#L361

On 22 November 2013 18:00, J=E9r=E9mie Galarneau
<jeremie.galarneau@efficios.com> wrote:
> Hi all,
>
> I received a number of great comments about the Babeltrace Python API
> since my last pull request. These patches, available on my personal
> repository, aim at making the API feel more natural to Python
> developers by using the appropriate language constructs where
> appropriate.
>
> The three "Fix" patches address bugs that were uncovered in the C
> codebase while developing and testing this patch set.
>
> https://github.com/jgalar/babeltrace.git
>
> 2be62ad Python-bindings: Refactor the Context class
> 32de3db Python-bindings: Refactor the TraceHandle class to use properties
> 7740532 Python-bindings: Refactor the Event class
> 10d1b96 Python-bindings: Move the _scopes array out of the Event class
> 99e8489 Python-bindings: Refactor the FieldDecl and EventDecl classes
> 425caab Python-bindings: Move declaration bindings out of the _Definition=
 class
> b5e4875 Fix: Use the bt_iter_set_pos function to set the begin_pos
> 3f8750e Fix: Take the iterator's end position into account
> 35e0cb7 Fix: bt_ctf_field_generic_validate should return < 0 on error
> 810922e Python-bindings: Refactor the CTFWriter API
>
> I think these patches bring us to a point where the bindings/python
> branch could be safely merged into master.
>
> Thanks,
> J=E9r=E9mie
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
