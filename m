From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Tracing page waits with LTTng 2.3.0
Date: Thu, 26 Sep 2013 15:27:40 -0400
Message-ID: <CA+jJMxvdy0z_Xs+aJ0BZZckXs3+ovOuSLzKu2woM4vGe_gSQ+Q__23781.7541267306$1380223726$gmane$org@mail.gmail.com>
References: <211FA304CEAAEE4AA25085F0CEB43BD70812D210@FR711WXCHMBA02.zeu.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VPHE2-00056W-2S
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 15:27:51 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq15so7588922wib.0
	for <lttng-dev@lists.lttng.org>; Thu, 26 Sep 2013 12:27:40 -0700 (PDT)
In-Reply-To: <211FA304CEAAEE4AA25085F0CEB43BD70812D210@FR711WXCHMBA02.zeu.alcatel-lucent.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Steffen, Kai-Uwe (Kai-Uwe)" <kai-uwe.steffen@alcatel-lucent.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

buffer_wait_start and buffer_wait_end were available because
__wait_on_buffer() (linux/fs/buffer.c:124) was instrumented. It is not
the case anymore so I'm afraid there are no equivalents.

Regards,
J=E9r=E9mie

On Mon, Sep 16, 2013 at 9:23 AM, Steffen, Kai-Uwe (Kai-Uwe)
<kai-uwe.steffen@alcatel-lucent.com> wrote:
> Hi.
>
>
>
> Currently I=92m working with LTTng 2.3.0 for Ubuntu 12.4, to see if this
> version would meet our requirements.
>
> With old LTT and LTTng 0.x it was possible to trace page waits.
>
> Tracepoints were called =93Page Wait=94 for LTT and =93buffer_wait_start=
=94
> =93buffer_wait_end=94 for LTTng 0.x.
>
>
>
> Now I looked for the tracepoints available with 2.3.0 and didn=92t find
> tracepoint for the page waits.
>
>
>
> Lttng list =96k
>
>
>
> Can you tell me if there is a tracepoint available in LTTng 2.3 or is it =
not
> supported yet?
>
>
>
> Thanks Kai
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
