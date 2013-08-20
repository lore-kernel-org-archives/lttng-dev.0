From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [RFC patch 1/3] [Babeltrace python bindings] Added
 missing call to _bt_ctf_get_decl_from_def() when calling
 _bt_ctf_get_int_len().
Date: Tue, 20 Aug 2013 12:31:19 -0400
Message-ID: <CA+jJMxuO5TVFP+mXNyVk2F=LmH-5fu8YVvrTFaDmrxfPzOPodg__21871.6024807238$1377016353$gmane$org@mail.gmail.com>
References: <OF1E3FA7DB.5BECB4A4-ONC2257BCD.002A81AE-C2257BCD.002AA547@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f176.google.com ([74.125.82.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VBoq5-0003RM-EZ
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 12:31:31 -0400
Received: by mail-we0-f176.google.com with SMTP id q56so616785wes.35
	for <lttng-dev@lists.lttng.org>; Tue, 20 Aug 2013 09:31:19 -0700 (PDT)
In-Reply-To: <OF1E3FA7DB.5BECB4A4-ONC2257BCD.002A81AE-C2257BCD.002AA547@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Something I forgot to mention when reviewing your first submission and
that applies to all patches from the series: we normally use the
present tense in the subject. Also, the subject line should not exceed
80 characters.
I don't know if Mathieu will prefer you resubmit or if he will make
the change himself.

Acked-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

Thanks,
J=E9r=E9mie

On Tue, Aug 20, 2013 at 3:46 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> The python code that called _bt_ctf_get_int_len() failed to wrap self._d
> with the call to _bt_ctf_get_decl_from_def.
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
