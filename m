From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace][RFC Patch][1/1] Add
 bt_ctf_get_decl_event_id() to obtain the event ID from the declaration
Date: Tue, 8 Apr 2014 12:25:44 -0400
Message-ID: <CA+jJMxvPMpWDWtvRVXW_vt7cKtD7u5yXDVHvWpJdas9tsnvmaw__23866.1149786369$1396974389$gmane$org@mail.gmail.com>
References: <OF9D8E0B6C.51939645-ONC2257CB4.00471398-C2257CB4.0047AC03@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXYqL-0001OU-Nw
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 12:25:52 -0400
Received: by mail-qa0-f50.google.com with SMTP id ih12so1169074qab.23
 for <lttng-dev@lists.lttng.org>; Tue, 08 Apr 2014 09:25:44 -0700 (PDT)
In-Reply-To: <OF9D8E0B6C.51939645-ONC2257CB4.00471398-C2257CB4.0047AC03@il.ibm.com>
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

Merged with some minor changes.

Thanks!
J=E9r=E9mie

On Tue, Apr 8, 2014 at 9:02 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hello all,
>
> This patch adds an API to obtain the event ID given a bt_ctf_event_decl
> pointer. This is useful after using bt_ctf_get_event_decl_list() to obtain
> the list of events that exist in a trace that was just opened.
>
> I have tried to make relevant additions to babeltrace.i.in in the Python
> bindings, as best I could, but have not tested these because I am not usi=
ng
> the Python bindings anymore.
>
>
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
