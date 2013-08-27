From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [REVIEW REQUEST babeltrace] Provide generic event
 payload accessors to the Python bindings
Date: Mon, 26 Aug 2013 20:40:40 -0400
Message-ID: <CA+jJMxv1fF2w6bszO14G_j+Fv__fs4G26gaLhE9-VaTU1_Goxw__6906.41493206403$1377564094$gmane$org@mail.gmail.com>
References: <CA+jJMxvw6sK3GVadKw2jt8mpciwV8Ts-A441wFJiesEbadj0Sg@mail.gmail.com>
	<20130826154855.GA17119@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VE7Kw-0006gB-PR
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 20:40:50 -0400
Received: by mail-wi0-f177.google.com with SMTP id cb5so2386017wib.16
	for <lttng-dev@lists.lttng.org>; Mon, 26 Aug 2013 17:40:40 -0700 (PDT)
In-Reply-To: <20130826154855.GA17119@Krystal>
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

On Mon, Aug 26, 2013 at 11:48 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
>> Hi all,
>>
>> I'd like to submit a review request for commits 34cf520 .. 3c5bb23 of
>> my bindings/python branch[1]. These are patches that were originally
>> contributed by Xiaona Han, that I have reviewed and to which I have
>> made minor changes (fixed typos and clarified some commit messages).
>
> Some comments:
>
> I notice e.g. in commit
> 34cf520df2f1df84a74a495a6f9a8d991f168c2e
> Return event fields by field name
>
> that the changelog appears to be really wide. In "git show", it goes
> beyond a 80-col screen. Please ensure that those changelogs are max 72
> lines in length, to make it easier to look at them in git show, and also
> to facilitate patch review, where they can easily become indented in
> reply messages,
>
> 6002606 Remove the unnecessary underscore prefix
> looks OK.
>
> fb0936d Support getting the value of enums
> looks OK.
>
>
> fb0ecd1c138a0b903090521406d239cf68b7e5e1
> Use a unique name to get a field's value
>
> +                       if id =3D=3D ctf.type_id.ARRAY:
> +                               return self.get_char_array()
>
> I not sure if it is already checked somewhere, but if we have an array
> of e.g. uint64_t elements (not characters), is it OK to return a char
> array ?
>
> I'd be tempted to return a char array only if the encoding is ASCII or
> UTF8, and only if the array contains 8-bit characters. But maybe this is
> validated elsewhere ?
>
> 5891c4d Support for the sequence type
> looks OK
>
> 3c5bb23 Add a python bindings sequence test
> looks OK
>

Thanks for your comments. I have addressed them and rebased the
patches on the latest tree.
The new revisions are 91c9c98 .. f0a440b.

Regards,
J=E9r=E9mie

> Thanks,
>
> Mathieu
>
>
>
>
>>
>> Thanks,
>> J=E9r=E9mie
>>
>> [1] git://github.com/jgalar/babeltrace.git -b bindings/python
>> Web: https://github.com/jgalar/babeltrace/tree/bindings/python
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
