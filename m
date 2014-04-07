From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Babeltrace API question - how can I determine event
 IDs that exist in a trace I opened?
Date: Mon, 7 Apr 2014 10:10:53 -0400
Message-ID: <CA+jJMxvBeK_8QJyg=jKTd8d5xT=2UXSFAVznY=mFj4T6XPxXwg__30235.796821262$1396879916$gmane$org@mail.gmail.com>
References: <OF6AA99225.C2D7812B-ONC2257CB2.00411006-C2257CB2.00414E93@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXAGJ-0008BD-5v
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 10:10:59 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so766614qgf.20
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 07:10:53 -0700 (PDT)
In-Reply-To: <OF6AA99225.C2D7812B-ONC2257CB2.00411006-C2257CB2.00414E93@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sun, Apr 6, 2014 at 7:53 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hi,
>
> Once I have created a context, and successfully added a trace, is there a
> way to determine which event IDs are present in the trace I just opened?

Have a look at bt_ctf_get_event_decl_list() in include/babeltrace/ctf/event=
s.h
This will return a list of struct bt_ctf_event_decl.

The event ID is in bt_ctf_event_decl.parent.id.

Regards,
J=E9r=E9mie

>
> Specifically, I would like to create a table linking event ID to its name,
> without iterating the entire trace to find out...
>
> Is this possible?
>
> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
