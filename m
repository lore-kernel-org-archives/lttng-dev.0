From: Robert Daniels <robert.daniels@vantagecontrols.com>
Subject: Re: ARM C++ segfaulting - follow-up
Date: Thu, 7 May 2015 18:19:43 +0000
Message-ID: <1431022783514.48712__25310.4860581972$1431022876$gmane$org@vantagecontrols.com>
References: <1431009677311.26279@vantagecontrols.com>,
 <141212120.45547.1431019897760.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-db3on0129.outbound.protection.outlook.com
 ([157.55.234.129] helo=emea01-db3-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <robert.daniels@vantagecontrols.com>)
 id 1YqQOl-0000BB-Vu
 for lttng-dev@lists.lttng.org; Thu, 07 May 2015 14:20:04 -0400
In-Reply-To: <141212120.45547.1431019897760.JavaMail.zimbra@efficios.com>
Content-Language: en-US
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

Great!  I guess I didn't catch that part about not compiling tracepoint pro=
bes with g++.

Thanks for a great tool!

- Robert

________________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Thursday, May 7, 2015 11:31 AM
To: Robert Daniels
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] ARM C++ segfaulting - follow-up

----- Original Message -----
> > I'm attempting to use lttng userspace tracing with a C++ application on=
 an
> > ARM platform. I'm using
> > GCC 4.8.4 on Linux 3.14 with the 2.6 release of lttng. I've compiled
> > lttng-modules, lttng-ust, and
> > lttng-tools and have been able to get a simple test working with C code.
> > When I attempt to run the
> > hello.cxx test on my target it will segfault.
>
>
> I spent a little time digging into this issue and finally discovered the
> cause of my segfault with ARM C++ tracepoints.
>
> There is a struct called 'lttng_event' in ust-events.h which contains an
> empty union 'u'.  This was the cause of my issue.  Under C, this empty un=
ion
> compiles to a zero byte member while under C++ it compiles to a one byte
> member, and in my case was four-byte aligned which caused my C++ code to
> have the 'cds_list_head node' offset incorrectly by four bytes.  This lead
> to an incorrect linked list structure which caused my issue.
>
> Since this union is empty, I simply removed it from the struct and everyt=
hing
> worked correctly.
>
> I don't know the history or purpose behind this empty union so I'd like to
> know if this is a safe fix.  If it is I can submit a patch with the union
> removed.

That's a very nice catch!

We do not support building tracepoint probe provider with
g++ yet, as stated in lttng-ust(3):

"        - Note for C++ support: although an application instrumented with
           tracepoints can be compiled with g++, tracepoint probes should be
           compiled with gcc (only tested with gcc so far)."

However, if it works fine with this fix, then I'm tempted to take it,
especially because removing the empty union does not appear to affect
the layout of struct lttng_event as seen from liblttng-ust, which must
be compiled with a C compiler,  and from probe providers compiled with
a C compiler. So all we are changing is the layout of a probe provider
compiled with a C++ compiler, which is anyway buggy at the moment,
because it is not compatible with the layout expected by liblttng-ust
compiled with a C compiler.

I'll push the fix in master, stable-2.6, and stable-2.5.

Thanks!

Mathieu


>
> Thanks,
>
> Robert Daniels
>
>
> ________________________________
>
> Ce message, ainsi que tous les fichiers joints =E0 ce message, peuvent co=
ntenir
> des informations sensibles et/ ou confidentielles ne devant pas =EAtre
> divulgu=E9es. Si vous n'=EAtes pas le destinataire de ce message (ou que =
vous
> recevez ce message par erreur), nous vous remercions de le notifier
> imm=E9diatement =E0 son exp=E9diteur, et de d=E9truire ce message. Toute =
copie,
> divulgation, modification, utilisation ou diffusion, non autoris=E9e, dir=
ecte
> ou indirecte, de tout ou partie de ce message, est strictement interdite.
> Se d=E9sabonner: Si vous souhaitez =EAtre retir=E9 de notre liste de diff=
usion,
> s'il vous pla=EEt envoyer vos coordonn=E9es =E0
> CASL.unsubscribe@legrand.ca<mailto:casl.unsubscribe@legrand.ca> et indiqu=
er
> quels sont les messages que vous ne souhaitez plus recevoir.
>
>
> This e-mail, and any document attached hereby, may contain confidential
> and/or privileged information. If you are not the intended recipient (or
> have received this e-mail in error) please notify the sender immediately =
and
> destroy this e-mail. Any unauthorized, direct or indirect, copying,
> disclosure, distribution or other use of the material or parts thereof is
> strictly forbidden.
> Unsubscribe: If you would like to be removed from our mailing list, please
> send your contact information to
> CASL.unsubscribe@legrand.ca<mailto:casl.unsubscribe@legrand.ca> and indic=
ate
> what messages you no longer wish to receive.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

________________________________

Ce message, ainsi que tous les fichiers joints =E0 ce message, peuvent cont=
enir des informations sensibles et/ ou confidentielles ne devant pas =EAtre=
 divulgu=E9es. Si vous n'=EAtes pas le destinataire de ce message (ou que v=
ous recevez ce message par erreur), nous vous remercions de le notifier imm=
=E9diatement =E0 son exp=E9diteur, et de d=E9truire ce message. Toute copie=
, divulgation, modification, utilisation ou diffusion, non autoris=E9e, dir=
ecte ou indirecte, de tout ou partie de ce message, est strictement interdi=
te.
Se d=E9sabonner: Si vous souhaitez =EAtre retir=E9 de notre liste de diffus=
ion, s'il vous pla=EEt envoyer vos coordonn=E9es =E0 CASL.unsubscribe@legra=
nd.ca<mailto:casl.unsubscribe@legrand.ca> et indiquer quels sont les messag=
es que vous ne souhaitez plus recevoir.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.
Unsubscribe: If you would like to be removed from our mailing list, please =
send your contact information to CASL.unsubscribe@legrand.ca<mailto:casl.un=
subscribe@legrand.ca> and indicate what messages you no longer wish to rece=
ive.
