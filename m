From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Can tracepoint be listed before app registered?
Date: Fri, 7 Mar 2014 13:23:01 -0500
Message-ID: <CA+jJMxtsE91pFis=SQbce0eHWS-vVfAiJg6deyvFSfp=B2WvYQ__37953.4146319658$1394216647$gmane$org@mail.gmail.com>
References: <tencent_6D2083A7444C8D7C02D4AD53@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WLzQJ-0003FK-G8
	for lttng-dev@lists.lttng.org; Fri, 07 Mar 2014 13:23:13 -0500
Received: by mail-qc0-f175.google.com with SMTP id e16so5113172qcx.34
	for <lttng-dev@lists.lttng.org>; Fri, 07 Mar 2014 10:23:02 -0800 (PST)
In-Reply-To: <tencent_6D2083A7444C8D7C02D4AD53@qq.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: zlynus <302590304@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Mar 7, 2014 at 12:26 PM, zlynus <302590304@qq.com> wrote:
> Hi,
> Sorry to bother you guys. The lttng-tool man page dosen't make it clear t=
hat
> when the tracepoints of user-space application can be listed. So I did a
> little test. As far as I can tell ,the tracepoint information is only
> available during the application is running.
>

Correct.

> So is it possible that the tracepoint can be available *before* app get
> running, specifically, before enable-event subcommand? I think it can be
> quite convenient to output the list when specify which events to trace. If
> it is not for now,
> maybe it's a feature worth working on. My idea is lttng-tool could read
> tracer provider library and get the info,and  add a option after 'list'
> subcommand which let user specify the provider library to read. Just a
> personal opion from a new comer :-)
>

You can enable an event before the app is started. However, as you
pointed out, the session daemon has no knowledge of application events
before they are launched.

My understanding of your suggestion is that we should define a public
provider API on which the lttng client could hook itself to list
events. It would be of limited use in the case of statically linked
providers, but It's an interesting problem... Do you have a specific
use-case in mind?

Regards,
J=E9r=E9mie

> Best regards,
> Lingyu Zhu
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
