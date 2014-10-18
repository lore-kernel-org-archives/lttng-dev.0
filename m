From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Re: Writing .tp files for lttng-gen-tp
Date: Sat, 18 Oct 2014 18:01:42 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286ACB0__16672.5727766336$1413655345$gmane$org@PAYTON.anl.gov>
References: <E949C1E351B4914B87A26A5F96E06A9286ABF8@PAYTON.anl.gov>
 <CAB4xu_1hoWpxQMFhxmukHxBQUTXOStxUX+sbneVpxTYKed75qA@mail.gmail.com>
 <E949C1E351B4914B87A26A5F96E06A9286AC60@PAYTON.anl.gov>,
 <CAB4xu_1N7U8_guz0-wGTRfELnGH1z19EeK2-Q18xuFVCCNHGhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XfYK5-0007Pi-5x
 for lttng-dev@lists.lttng.org; Sat, 18 Oct 2014 14:01:50 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id AFC1D7CC288
 for <lttng-dev@lists.lttng.org>; Sat, 18 Oct 2014 13:01:43 -0500 (CDT)
In-Reply-To: <CAB4xu_1N7U8_guz0-wGTRfELnGH1z19EeK2-Q18xuFVCCNHGhQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks, this is a very good idea. I will do that.

> ________________________________________
> From: Philippe Proulx [eeppeliteloop@gmail.com]
> Sent: Saturday, October 18, 2014 12:58 PM
> To: Boisvert, Sebastien
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Writing .tp files for lttng-gen-tp
> On Sat, Oct 18, 2014 at 10:39 AM, Boisvert, Sebastien <boisvert@anl.gov> =
wrote:
> >
> > Hi,
> >
> > I changed the provider name to thorium_message.
> >
> > I also tried using a macro in the template file, but the define alone
> > breaks things.
> >
> > Template file: https://github.com/sebhtml/biosal/blob/master/engine/tho=
rium/tracepoints/lttng/message.tp (the macro is commented)
> >
> >
> > Uncommenting the macro produces these warnings:
> >
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> > Warning: different domain provided (int,thorium_message)
> >
> > And the linker fails.
> Yes, sorry about that, I didn't look at the output.
> lttng-gen-tp has some bugs. It parses everything using regexes, so I gues=
s it
> won't deal properly with custom C preprocessor stuff reusing
> TRACEPOINT_EVENT() within a macro. For some reason, it detects `int` as
> the tracepoint provider name ("domain" in lttng-gen-tp's jargon).
> IMO your use case might already be too advanced for lttng-gen-tp, so I wo=
uld
> advise that you have a look at defining plain tracepoint providers without
> using lttng-gen-tp: <http://lttng.org/docs/#doc-tracepoint-provider>. It
> basically involves writing a proper template header. The hardest part
> is defining
> the tracepoints using TRACEPOINT_EVENT(), but you already did that.
> So start with this (TP provider name fixed):
> * message.h: <http://pastebin.com/yiqN0CEj>
> * message.c: <http://pastebin.com/BmXiSCbd>
> Build it like this:
> gcc -I../../../.. -I. -c message.c
> and link the resulting message.o with your application as usual.
> >
> > > ________________________________________
> > > From: Philippe Proulx [eeppeliteloop@gmail.com]
> > > Sent: Friday, October 17, 2014 9:36 PM
> > > To: Boisvert, Sebastien
> > > Cc: lttng-dev@lists.lttng.org
> > > Subject: Re: [lttng-dev] Writing .tp files for lttng-gen-tp
> > > On Fri, Oct 17, 2014 at 5:39 PM, Boisvert, Sebastien <boisvert@anl.go=
v> wrote:
> > > > Hi,
> > > >
> > > > I wrote a big .tp file to define numerous tracepoints that only dif=
fer in the event name.
> > > > They all take the same arguments and they all dump the same fields.
> > > >
> > > >
> > > > .tp file: https://github.com/sebhtml/biosal/blob/master/engine/thor=
ium/tracepoints/lttng/message.tp
> > > >
> > > >
> > > > Is there a more compact way of doing that ?
> > > Yes; note that a template file is just part of an eventual C header
> > > file, so C preprocessor
> > > stuff is accepted. This should work:
> > > #include <engine/thorium/message.h>
> > > #define THORIUM_MSG_TP(name) \
> > > TRACEPOINT_EVENT( \
> > > message, \
> > > name, \
> > > TP_ARGS( \
> > > struct thorium_message *, msg \
> > > ), \
> > > TP_FIELDS( \
> > > ctf_integer(int, message_number, msg->number) \
> > > ctf_integer(int, message_action, msg->action) \
> > > ctf_integer(int, message_count, msg->count) \
> > > ctf_integer(int, message_source_actor, msg->source_actor) \
> > > ctf_integer(int, message_destination_actor,
> > > msg->destination_actor) \
> > > ctf_integer(int, message_source_node, msg->source_node) \
> > > ctf_integer(int, message_destination_node,
> > > msg->destination_node) \
> > > ) \
> > > )
> > > THORIUM_MSG_TP(actor_send)
> > > THORIUM_MSG_TP(node_send)
> > > THORIUM_MSG_TP(worker_send)
> > > THORIUM_MSG_TP(worker_receive)
> > > THORIUM_MSG_TP(worker_send_mailbox)
> > > THORIUM_MSG_TP(worker_send_schedule)
> > > THORIUM_MSG_TP(worker_pool_enqueue)
> > > THORIUM_MSG_TP(worker_pool_dequeue)
> > > THORIUM_MSG_TP(worker_enqueue_message)
> > > THORIUM_MSG_TP(actor_receive)
> > > THORIUM_MSG_TP(worker_dequeue_message)
> > > THORIUM_MSG_TP(node_send_system)
> > > THORIUM_MSG_TP(node_receive)
> > > THORIUM_MSG_TP(node_receive_message)
> > > THORIUM_MSG_TP(node_send_dispatch)
> > > THORIUM_MSG_TP(node_dispatch_message)
> > > THORIUM_MSG_TP(transport_send)
> > > THORIUM_MSG_TP(transport_receive)
> > > Please write back if it does not.
> > > BTW, I would suggest that your tracepoint provider name (currently `m=
essage`) be
> > > more specific as to what your application really is, e.g., `thorium_m=
sg`.
> > > Phil
> > > >
> > > >
> > > >                 S=E9bastien
> > > >
> > > >
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
