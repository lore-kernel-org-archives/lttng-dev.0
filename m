From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Trace rotation across sessions
Date: Tue, 18 Mar 2014 10:19:47 -0400
Message-ID: <CA+jJMxsBWqc24+ib8QVmTzx85PG6eXkGYOHD5=6R2ehRUCBzOw__29135.3169283413$1395152476$gmane$org@mail.gmail.com>
References: <OFBBFCF198.C68E7A66-ONC2257C9F.00309BBF-C2257C9F.0030CCEA@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WPurx-0001yM-AN
	for lttng-dev@lists.lttng.org; Tue, 18 Mar 2014 10:19:59 -0400
Received: by mail-qc0-f175.google.com with SMTP id e16so7733751qcx.20
	for <lttng-dev@lists.lttng.org>; Tue, 18 Mar 2014 07:19:47 -0700 (PDT)
In-Reply-To: <OFBBFCF198.C68E7A66-ONC2257C9F.00309BBF-C2257C9F.0030CCEA@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 18, 2014 at 4:52 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hello,
>
> Our system has a running session that stays on continuously.
>
> Occasionally, our customer will upgrade the software, leading to a reboot,
> which in turn means we will have a new session.
>
> Is there any way to make LTTng aware of the total size of all sessions
> (current and past) and simply rotate files to keep the entire set of trac=
es
> under a size limit?
>

The only way I can see this working is by recreating the same session
configuration (with the same output destination) and using lttng
enable-channel's -C (tracefile-size) and -W (tracefile-count) options
to define an upper bound on each trace's size.

Is this what you are looking for?

J=E9r=E9mie

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
