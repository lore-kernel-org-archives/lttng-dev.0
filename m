From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: RFC LTTng session and daemon configuration save and
	restore
Date: Thu, 5 Dec 2013 12:56:36 -0500
Message-ID: <CA+jJMxt83kW6W0-9FGyAGyTSx-9wu5Warm6e8FFLEVGb1tErMg__23103.3306722113$1386266239$gmane$org@mail.gmail.com>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
	<52A0B9FF.4040501@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VodAH-00013C-Rf
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 12:56:43 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so27063qaq.19
	for <lttng-dev@lists.lttng.org>; Thu, 05 Dec 2013 09:56:36 -0800 (PST)
In-Reply-To: <52A0B9FF.4040501@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 5, 2013 at 12:38 PM, Stefan Seefeld
<stefan_seefeld@mentor.com> wrote:
> Hi J=E9r=E9mie,
>
>
>
> On 12/04/2013 04:33 PM, J=E9r=E9mie Galarneau wrote:
>> RFC - LTTng session and daemon configuration save and restore
>
> I think this is a great idea.
>
>
>> Session Configuration File Format
>> ---------------------------------
>>
>> Finally, it seems that using a standard hierarchical format such as JSON=
 or
>> XML would be the most appropriate choice. Both of these formats have int=
rinsic
>> support for representation of hierarchical relationships. They also bene=
fit from
>> having a lot of hardened external libraries that will provide parsing,
>> validation and write support.
>
> I fully agree that re-inventing another language (which includes both
> syntax and semantics !) is not an easy task, and should be avoided for
> lots of reasons. In fact, I would also avoid XML for that same reason,
> as it's not really a language in itself, rather than a baseline on top
> of which a language may be defined.

I don't see an XML schema as something as demanding as defining a new
language. One of the reasons why I prefer XML here is that the schema
really makes it easy to validate the files and integrate with existing
tools.

>
> There are a few existing proven solutions that are widely used in many
> different domains, all involving scripting languages that can easily be
> layered on top of C/C++ APIs. Two of the most commonly used are Python
> and Lua, which would allow you to write configuration files as Python /
> Lua scripts.
>
> Have you considered those ?

Not really. I guess it makes sense to have these script-config files
when your application is written in that language, but I'm not sure I
see the benefit here.

Furthermore, I think the integration of a LUA/Python interpreter in
lttng-tools would not go down well.

Thanks,
J=E9r=E9mie

>
> Regards,
>         Stefan
>
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
