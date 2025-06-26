Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438DCC7115B
	for <lttng-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bSWrp4K7Sz1d1c
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750926156;
	b=nP5Q5VgQCQrw+YTLoXFbRroTmR4W2LMhPKjkhd404TcJtxLKokloM6KU1UfKPcvAj6cW
	 kTg080OmNlCh5o9uNst2+JDw3DeONC1Pg7LG3D1KJQ1VqaCh+WT4kCC6DyQ5ot2Ygg8fZ
	 PL8ujLFiC1FPZ2l3vRY/wEz3Y1xnBx78scxFkrPR9hgxAE0tfIVa9xsvpUxQU1hV5k+N9
	 hD+uhKBC4WDsVpOGaZhEuwhRbMrvnleaNUbChs0LGjuq3OqYgdlze1ta7vRFmGRFGDhsx
	 uAYjgCWlKcLmiRh3gqFbehECNsdIyjKODyadZErxbhALJ3zi9msxQT3U1mcZ7e6vgdw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750926156;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=PWPqAYBwdfuYtZtlyN58aNNJj9LcVhFoEABN32iIlWg=;
	b=DSFqAHgcy2v1r/ZND4JWQFpMg0koZ2QsxyNckptXB+P5wuBJ3AdcH+hq6kkcNgvyQJ/v
	 epY7yusUBxWP2uHjPVgib5taXOQCuzuK+t19Si8SQ97wrnoOjXLJ9BGI5UYgdkr8Ny1rN
	 CV3QD7TJEu2VsgPLHzXlY3p7uWLSkEhNMJqDnXtaAj2+J6Ub9Fh7yfdcdMSkYItim61k8
	 LhwddU6tGjABjO09G8XwRCpnprdNotxPaJXS7bneZeci6Kq4Pv/DCqUrNFGiCTbvszhsr
	 IFQ8Cbr8xhVY0UhPrpGizkEjLCWvTs4+4so42HDl4kKuUdsoWybiokNjw6nJkLdp9TQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bSWrp4K7Sz1d1c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750926156;
	bh=PWPqAYBwdfuYtZtlyN58aNNJj9LcVhFoEABN32iIlWg=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wWBqe4lfeEDlAager1UBpGLxQ048PW6ZzWCPbI5mTlY5N11SVUbcZ6WnOEhCv9/+v
	 ZSsclsQzJ3TpU0ArdyfTXQ+aL09U8RABKZA8vEKZId4VZImLWT4sOi6p8dRiWKyrzF
	 GgTHuT1Ktj7mrY7HC9Z3sCR3jcrLbLYcWTXuq34R0Cb0xrBM5XSBhyl2gk9X57P6Jl
	 3TiclAO32V1iLmsrF0Owid3eDwo/1g7HlqOvv76TmR/AYCOyXcNWyp4vq/0zeEfT6e
	 7+nUVewtzh624bJFTiTqBiDru9pLYW/lPWh2IWHc9oA92eB/2S/T4eov9QpKgsbVgf
	 pwGJGUgGB1uIA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bSWrp4K7Sz1d1c;
	Thu, 26 Jun 2025 04:22:34 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bSWrn1MPTz1d1Z
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bSWrn1MPTz1d1Z
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 by lists.lttng.org (Postfix) with ESMTPS id 4bSWrn1MPTz1d1Z
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jun 2025 04:22:32 -0400 (EDT)
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3da82c6c5d4so6211705ab.1
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jun 2025 01:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750926151; x=1751530951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=um8Qkfp329hxxdg1bqMwd+hI1X+uH2PCrBNbKMWergo=;
 b=mvZ5+Z8LoRh4l6folkvznOm/qavBQ8FBrwQeSjxZdmiccwLxknAkw9F4707DxPk/Rh
 N3mxntPIIVzPieckUNw7HKna7p9xbJC/aBFTFwgVrBJBfTXiTXpp/UKtnhiNTxdBBYVT
 TqSPEormNIRQaDRSu3IvJSIabOCwgvIOqw519PIaxEZUuxdBY/5qTqgXzmfNJAIPiV+/
 rgDxlrx/wlS58mdvNjSB3dgE3sRUGiDtgQKa+MgRttjGjv5KwbJgmckYXzWp+pHmB/q3
 ZUXXAEYUDxwCIOUH76QSlFhjtdh1MOSLS8Y29BjDaYdCCcjyOk4XcAVxS4OzwHQsp0Qw
 nF/w==
X-Gm-Message-State: AOJu0Yx9YbXT2dHe2V04QEaOkjxDj+1daQ7cARzqLiBxB+ghtgmbito4
 Vsupj32YxE+xjLr5ZhN5LbW8Fq9YvHvGddGl3oAVHtaxEIRB0EQQLHwaRW8p8kGLXWwgkP+xZ3b
 LFhGC1rqpA9TBJR/i+33zHjjejo6j6DA=
X-Gm-Gg: ASbGncsbrkKnKjOQAAmnxl6xA/nQbUjbTJf3xst3dG05LhHzztuN+iFUuTjtf1R3NEk
 gkTJq8apsowKTRqicMEYMsfEOvArDq6o/L0mdar20ADE+rOotS/6/tZIVs858lvkEd0chsTD+cT
 nigt5uOhbPYNlTsvsI5t5upxWQfiqq7j4KMyfDoob97w==
X-Google-Smtp-Source: AGHT+IHlLTmaXv7flv8SeJnHyTAnCcZp4DIDCWDjsXw7RBm5HFAqX5NRNwoZ5Dgjk4dMvGQKHBULHZsiyl6XroM2RpM=
X-Received: by 2002:a05:6e02:1fc9:b0:3dc:8b57:b750 with SMTP id
 e9e14a558f8ab-3df32a0af03mr77732615ab.17.1750926151173; Thu, 26 Jun 2025
 01:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEobtPOhc8K3c-Qcymm1m-pRpHSZyDSarAKoGKeiKqZfUqXOCQ@mail.gmail.com>
 <34912d84-7750-454c-9f96-fb8d865ba8d8@efficios.com>
 <CAEobtPN-Yq_zpu18FsbS-2s4WhJhpEgjK2yuQ+NeOxcGFuaENg@mail.gmail.com>
 <6914656f-9b7b-43fa-9dd1-9b27506c6d2a@efficios.com>
 <CAEobtPPKOTgJKObVg2hFe2TPR15gTybut=QqrgFhzkPAF3qe5Q@mail.gmail.com>
 <df4912fc-ccc3-442e-96cb-9d8de791b284@efficios.com>
In-Reply-To: <df4912fc-ccc3-442e-96cb-9d8de791b284@efficios.com>
Date: Thu, 26 Jun 2025 10:22:18 +0200
X-Gm-Features: Ac12FXxnqUdeX66zkQVimw464XYNffWVqB-BfxCRUDENGXwggRY9WyyFAzaWGDw
Message-ID: <CAEobtPNbK2DdbfJf4wZx+X3TH_RWWQ22knJhytd6Z2pBbdG+dw@mail.gmail.com>
Subject: Re: Malformed Tracefiles
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="00000000000044cd4c0638754320"
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Georg Muck via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Georg Muck <georgmuck1@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--00000000000044cd4c0638754320
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

switching to tracing per uid solved the Problem.

Huge thanks for your patients!


Best regards,

Georg


Never burn the bridges before you
If you've burned the bridges behind
Never burn the one that you're walking upon
Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*

Kienan Stewart <kstewart@efficios.com> schrieb am Mi., 25. Juni 2025, 22:52=
:

> Hi Georg,
>
> On 6/25/25 1:27 PM, Georg Muck wrote:
> > Hi Kienan,
> >
> > thanks for your quick response. :)
> >
> > I replaced "--daemonize" with "--background".
> >
> > I guess I should briefly describe my goal to avoid confusion: I want to
> > trace a ROS2-session online (tried LTTng-live, but it costs too much
> > ressources, hence the aggressive rotation of 1s). LTTng gives me the pa=
th
> > to a newly created trace-file as soon as it is created. This path is
> > forwarded to a Thread-Pool that does the rest (analyses each tracefile =
by
> > itself)=E2=80=A6 . However, the tracefiles are removed in the end, caus=
e I'm not
> > interested in them, only the program should be interested in them (forg=
ot
> > to remove it in the example). The problem only occurs when I start to
> many
> > ROS2 instances at once, meaning gathering too many tracepoints at once
> (at
> > once meaning in a very short amount of time). It works fine for 1-2
> > instances, but it doesn't work for 16 instances.
> >
> >> 1. *Before any traced application is run, babeltrace2 has the followin=
g
> > error output:* Ah ok, thought I would be on the right track.
> >> 2. *After a traced application is run whether is produces enabled even=
ts
> > or not, I see the events recorded*: What do you mean by that? There is =
no
> > babeltrace2 error if traced instances are running, even tho they are no=
t
> > creating events?
>
> This is what I observed with a fresh start:
>
> before running any traced application: bt2 error with no traced content
>
> after running a traced application with no events: bt2 no longer
> produced an error, but output 0 events (as expected).
>
> In this case I expect that it is because the consumer started and basic
> metadata was available so that was written in the snapshot. If I recall
> correctly, the consumer daemon only starts when the first application
> connects
>
> after running a traced application with some events: as usual
> >> 3. *When your session script stops, the output folder is deleted*: lik=
e
> > described, forgot to remove, but it is on purpose
> >
> > I tried *tp**:tptest*, but there is no output shown by babeltrace2 (is
> that
> > intended?):
> >
>
> I had the 100 events produced by gen-ust-events binary that invoked. You
> ran it but the events weren't recorded? Regardless I think we're on the
> same page that the session setup program you are using is fine right now.
>
> > [georg@KARTOFF8xE-zenbook /tmp/structural_traces]$ babeltrace2 archives
> > [georg@KARTOFF8xE-zenbook /tmp/structural_traces]$
> >
> >
> > However, I figured something out:
> > When I trace the "ros:rcl_node_init"-Tracepoint and start 12 ROS2
> > Instances, I receive the following output for the entire
> archive-directory:
> > [georg@KARTOFF8xE-zenbook /tmp/structural_traces/archives]$ babeltrace2
> .
> >
> > [19:01:41.474172508] (+?.?????????) KARTOFF8xE-zenbook:listener:(24897)
> > ros2:rcl_node_init: { cpu_id =3D 1 }, { procname =3D "listener", vpid =
=3D 24897
> > }, { node_handle =3D 0x5CCBD0EFA280, rmw_handle =3D 0x5CCBD107A420,
> node_name =3D
> > "saturn_listener", namespace =3D "/hallo/saturn" }
> > [19:01:41.493613263] (+0.019440755) KARTOFF8xE-zenbook:talker:(24898)
> > ros2:rcl_node_init: { cpu_id =3D 4 }, { procname =3D "talker", vpid =3D=
 24898
> },
> > { node_handle =3D 0x5A8E10DFC6E0, rmw_handle =3D 0x5A8E10F8AA60, node_n=
ame =3D
> > "erde_talker", namespace =3D "/hallo/erde" }
> >
> > All coming from archive-file number 10:
> > [georg@KARTOFF8xE-zenbook
> >
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200=
-10]$
> > babeltrace2 .
> >
> > [19:01:41.474172508] (+?.?????????) KARTOFF8xE-zenbook:listener:(*24897=
*)
> > ros2:rcl_node_init: { cpu_id =3D 1 }, { procname =3D "listener", vpid =
=3D 24897
> > }, { node_handle =3D 0x5CCBD0EFA280, rmw_handle =3D 0x5CCBD107A420,
> node_name =3D
> > "saturn_listener", namespace =3D "/hallo/saturn" }
> > [19:01:41.493613263] (+0.019440755) KARTOFF8xE-zenbook:talker:(24898)
> > ros2:rcl_node_init: { cpu_id =3D 4 }, { procname =3D "talker", vpid =3D=
 24898
> },
> > { node_handle =3D 0x5A8E10DFC6E0, rmw_handle =3D 0x5A8E10F8AA60, node_n=
ame =3D
> > "erde_talker", namespace =3D "/hallo/erde" }
> >
> > However, looking deeper into that file I saw that there are all 12
> > instances (+some of ros2 itself) I started within the trace-directory
> > number 10!
> > [georg@KARTOFF8xE-zenbook
> >
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200=
-10/ust/pid]$
> > ls
> >
> > listener-24897-20250625-190141  listener-24903-20250625-190141
> >   ros2-24447-20250625-190131  ros2-24887-20250625-190141
> >   talker-24900-20250625-190141  talker-24916-20250625-190141
> > listener-24899-20250625-190141  listener-24914-20250625-190141
> >   ros2-24451-20250625-190131  talker-24896-20250625-190141
> >   talker-24902-20250625-190141
> > listener-24901-20250625-190141  listener-24917-20250625-190141
> >   ros2-24834-20250625-190134  talker-24898-20250625-190141
> >   talker-24904-20250625-190141
> >
> > BUT:
> > I looked into the specific directory of a traced instance (underlined i=
t)
> > [georg@KARTOFF8xE-zenbook
> >
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200=
-10/ust/pid]$
> > ls listener-*24897*-20250625-190141/
> >
> > index     structuralChannel_0  structuralChannel_2  structuralChannel_4
> >   structuralChannel_6  structuralChannel_8  structuralChannel_10
> > *metadata*  structuralChannel_1  structuralChannel_3  structuralChannel=
_5
> >   structuralChannel_7  structuralChannel_9  structuralChannel_11
> >
> > and of a non-traced instance:
> > [georg@KARTOFF8xE-zenbook
> >
> /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0200=
-10/ust/pid]$
> > ls listener-24899-20250625-190141
> >
> > index                structuralChannel_1  structuralChannel_3
> >   structuralChannel_5  structuralChannel_7  structuralChannel_9
> > structuralChannel_11
> > structuralChannel_0  structuralChannel_2  structuralChannel_4
> >   structuralChannel_6  structuralChannel_8  structuralChannel_10
> >
> > Turns out: There is no metadata file within the second one. Therefore
> > babeltrace2 is not able to parse the file. Do you have an idea why?
> >
>
>  From your later e-mail with the updated sessiond log which shows the
> PERROR for too many open files it sounds like you have a thread to pull o=
n.
>
> You can try using the per-uid buffering scheme to reduce the number of
> FDs required when running 12 concurrent instances of ros.
>
> > Best regards,
> > Georg
> >
> > Never burn the bridges before you
> > If you've burned the bridges behind
> > Never burn the one that you're walking upon
> > Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
> >
> >
> > Am Mi., 25. Juni 2025 um 17:50 Uhr schrieb Kienan Stewart <
> > kstewart@efficios.com>:
> >
> >> Hi Georg,
> >>
> >> On 6/25/25 9:36 AM, Georg Muck wrote:
> >>> Hi Kienan,
> >>>
> >>> I did exactly that, without success.
> >>>
> >>> The log of the lttng-sessiond (lttng.log) did not change after starti=
ng
> >> the
> >>> ROS2 instances. I have also added the output of "lttng list
> >>> structuralSession"
> >>> I start my tracing instance as follows:
> >>>
> >>> At first there is a bash-script that sets everything up, it does the
> >>> following:
> >>>
> >>> lttng destroy -a # to destroy all existing sessions
> >>> lttng-sessiond --daemonize --verbose-consumer -vvv &> "/tmp/lttng.log=
"
> #
> >>
> >> When started with '--daemonize', the file descriptors are closed[1]
> >> after forking which is why you don't see any further output to
> >> /tmp/lttng.log. Try with '--background' instead.
> >>
> >>> starting a new session Deamon
> >>> ./exemplary_tracing_session # starting my exemplary tracing session
> >>>
> >>> The exemplary tracing session is written by the help of the c Api
> >>> (appendix).
> >>>
> >>
> >> I modified your script to add 'tp:tptest' (a tracepoint from the
> >> lttng-tools test suite program gen-ust-events) and did the following:
> >>
> >> ```
> >> $ lttng-sessiond --background --verbose-consumer -vvv &> sessiond.log
> >> $ ./exemplary_tracing_session &
> >> $ lttng-tools/./tests/utils/testapp/gen-ust-events/gen-ust-events
> >> babeltrace2 /tmp/structural_traces | wc -l
> >> 100
> >> ```
> >>
> >> It seems to be working fine for me. A couple of notes:
> >>
> >> 1. Before any traced application is run, babeltrace2 has the following
> >> error output: No trace was found based on input `/tmp/structural_trace=
s`
> >> 2. After a traced application is run whether is produces enabled event=
s
> >> or not, I see the events recorded.
> >> 3. When your session script stops, the output folder is deleted.
> >>
> >>> I started the the same procedure on another machine. The same fault
> >>
> >> The fault is that the babeltrace2 has an error, right? Are you willing
> >> to share your trace that has the problem and/or show the output of
> >> babeltrace2's error?
> >>
> >>> occurred. I think I need to configure more within the `lttngDomain`.
> But
> >> I
> >>> don't know how, would you have an idea/hint?
> >>>
> >>> Thanks for your help.
> >>>
> >>> Best regards,
> >>> Georg
> >>>
> >>> Ps.: I also added the log of my tracing tool (structural.log)
> >>>
> >>> Never burn the bridges before you
> >>> If you've burned the bridges behind
> >>> Never burn the one that you're walking upon
> >>> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*
> >>>
> >>>
> >>> Am Mo., 23. Juni 2025 um 16:26 Uhr schrieb Kienan Stewart <
> >>> kstewart@efficios.com>:
> >>>
> >>>> Hi Georg,
> >>>>
> >>>> a good first step is to run lttng-session with `-vvv
> --verbose-consumer`
> >>>> and inspect the log file and `LTTNG_UST_DEBUG=3D1` in the environmen=
t.
> >>>>
> >>>> It may also be useful to run your traced applications with
> >>>> `LTTNG_UST_DEBUG=3D1` set in the environment.
> >>>>
> >>>> Do you have steps that reproduce the issue? E.g., all the commands t=
o
> >>>> set up the tracing session and so forth.
> >>>>
> >>>> thanks,
> >>>> kienan
> >>>>
> >>>> On 6/19/25 10:58 AM, Georg Muck via lttng-dev wrote:
> >>>>> Hey,
> >>>>>
> >>>>> I am using the LTTng tracer (2.13.11, C-API, rotation=3D1s) to trac=
e my
> >>>> ROS2
> >>>>> system (userspace only). Everything works just fine within my Docke=
r
> >>>>> Container (Ubuntu 24.04), but if I start the same procedure on the
> host
> >>>>> itself (also Ubuntu 24.04), it does not create a TraceFile if to ma=
ny
> >>>>> tracepoints occur (speaking of roundabout 1500+ per second)
> (sometimes
> >> it
> >>>>> malformed the tracefile, but I was not able to recreate that. If I
> >>>> remember
> >>>>> correctly, Babeltrace2 threw an error that said that there was no
> >>>>> metadata-file). I played around with some configurations (like
> >> increasing
> >>>>> the buffer size from ~16kB to ~512kB or a less aggressive rotation)=
,
> >> but
> >>>>> the problem stayed.
> >>>>>
> >>>>> Would be thankful for help. I guess I delivered to less information=
,
> >>>> please
> >>>>> reach out what is interesting at this point, I am not sure about th=
at
> >> :).
> >>>>>
> >>>>> Best regards,
> >>>>> Georg
> >>>>>
> >>>>>
> >>>>>
> >>>>> Never burn the bridges before you
> >>>>> If you've burned the bridges behind
> >>>>> Never burn the one that you're walking upon
> >>>>> Or you're sure to hit the water in time. *(Savatage, Streets, 1991)=
*
> >>>>>
> >>>>
> >>>>
> >>>
> >>
> >> thanks,
> >> kienan
> >>
> >> [1]: https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-opt--daemonize
> >>
> >
>
>

--00000000000044cd4c0638754320
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p dir=3D"ltr">Hi Kienan,</p>
<p dir=3D"ltr">switching to tracing per uid solved the Problem.</p><p dir=
=3D"ltr">Huge thanks for your patients!</p><p dir=3D"ltr"><br></p><p dir=3D=
"ltr">Best regards,</p><p dir=3D"ltr">Georg=C2=A0</p><p dir=3D"ltr"><br></p=
><div data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><span style=3D"co=
lor:rgb(80,0,80)">Never burn the bridges before you</span><br style=3D"colo=
r:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">If you&#39;ve burned the=
 bridges behind</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color=
:rgb(80,0,80)">Never burn the one that you&#39;re walking upon</span><br st=
yle=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">Or you&#39;re=
 sure to hit the water in time. <i>(Savatage, Streets, 1991)</i></span><br>=
</div></div></div>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Kienan=
 Stewart &lt;<a href=3D"mailto:kstewart@efficios.com" target=3D"_blank" rel=
=3D"noreferrer">kstewart@efficios.com</a>&gt; schrieb am Mi., 25. Juni 2025=
, 22:52:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Georg,<br>
<br>
On 6/25/25 1:27 PM, Georg Muck wrote:<br>
&gt; Hi Kienan,<br>
&gt; <br>
&gt; thanks for your quick response. :)<br>
&gt; <br>
&gt; I replaced &quot;--daemonize&quot; with &quot;--background&quot;.<br>
&gt; <br>
&gt; I guess I should briefly describe my goal to avoid confusion: I want t=
o<br>
&gt; trace a ROS2-session online (tried LTTng-live, but it costs too much<b=
r>
&gt; ressources, hence the aggressive rotation of 1s). LTTng gives me the p=
ath<br>
&gt; to a newly created trace-file as soon as it is created. This path is<b=
r>
&gt; forwarded to a Thread-Pool that does the rest (analyses each tracefile=
 by<br>
&gt; itself)=E2=80=A6 . However, the tracefiles are removed in the end, cau=
se I&#39;m not<br>
&gt; interested in them, only the program should be interested in them (for=
got<br>
&gt; to remove it in the example). The problem only occurs when I start to =
many<br>
&gt; ROS2 instances at once, meaning gathering too many tracepoints at once=
 (at<br>
&gt; once meaning in a very short amount of time). It works fine for 1-2<br=
>
&gt; instances, but it doesn&#39;t work for 16 instances.<br>
&gt; <br>
&gt;&gt; 1. *Before any traced application is run, babeltrace2 has the foll=
owing<br>
&gt; error output:* Ah ok, thought I would be on the right track.<br>
&gt;&gt; 2. *After a traced application is run whether is produces enabled =
events<br>
&gt; or not, I see the events recorded*: What do you mean by that? There is=
 no<br>
&gt; babeltrace2 error if traced instances are running, even tho they are n=
ot<br>
&gt; creating events?<br>
<br>
This is what I observed with a fresh start:<br>
<br>
before running any traced application: bt2 error with no traced content<br>
<br>
after running a traced application with no events: bt2 no longer <br>
produced an error, but output 0 events (as expected).<br>
<br>
In this case I expect that it is because the consumer started and basic <br=
>
metadata was available so that was written in the snapshot. If I recall <br=
>
correctly, the consumer daemon only starts when the first application <br>
connects<br>
<br>
after running a traced application with some events: as usual<br>
&gt;&gt; 3. *When your session script stops, the output folder is deleted*:=
 like<br>
&gt; described, forgot to remove, but it is on purpose<br>
&gt; <br>
&gt; I tried *tp**:tptest*, but there is no output shown by babeltrace2 (is=
 that<br>
&gt; intended?):<br>
&gt; <br>
<br>
I had the 100 events produced by gen-ust-events binary that invoked. You <b=
r>
ran it but the events weren&#39;t recorded? Regardless I think we&#39;re on=
 the <br>
same page that the session setup program you are using is fine right now.<b=
r>
<br>
&gt; [georg@KARTOFF8xE-zenbook /tmp/structural_traces]$ babeltrace2 archive=
s<br>
&gt; [georg@KARTOFF8xE-zenbook /tmp/structural_traces]$<br>
&gt; <br>
&gt; <br>
&gt; However, I figured something out:<br>
&gt; When I trace the &quot;ros:rcl_node_init&quot;-Tracepoint and start 12=
 ROS2<br>
&gt; Instances, I receive the following output for the entire archive-direc=
tory:<br>
&gt; [georg@KARTOFF8xE-zenbook /tmp/structural_traces/archives]$ babeltrace=
2 .<br>
&gt; <br>
&gt; [19:01:41.474172508] (+?.?????????) KARTOFF8xE-zenbook:listener:(24897=
)<br>
&gt; ros2:rcl_node_init: { cpu_id =3D 1 }, { procname =3D &quot;listener&qu=
ot;, vpid =3D 24897<br>
&gt; }, { node_handle =3D 0x5CCBD0EFA280, rmw_handle =3D 0x5CCBD107A420, no=
de_name =3D<br>
&gt; &quot;saturn_listener&quot;, namespace =3D &quot;/hallo/saturn&quot; }=
<br>
&gt; [19:01:41.493613263] (+0.019440755) KARTOFF8xE-zenbook:talker:(24898)<=
br>
&gt; ros2:rcl_node_init: { cpu_id =3D 4 }, { procname =3D &quot;talker&quot=
;, vpid =3D 24898 },<br>
&gt; { node_handle =3D 0x5A8E10DFC6E0, rmw_handle =3D 0x5A8E10F8AA60, node_=
name =3D<br>
&gt; &quot;erde_talker&quot;, namespace =3D &quot;/hallo/erde&quot; }<br>
&gt; <br>
&gt; All coming from archive-file number 10:<br>
&gt; [georg@KARTOFF8xE-zenbook<br>
&gt; /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0=
200-10]$<br>
&gt; babeltrace2 .<br>
&gt; <br>
&gt; [19:01:41.474172508] (+?.?????????) KARTOFF8xE-zenbook:listener:(*2489=
7*)<br>
&gt; ros2:rcl_node_init: { cpu_id =3D 1 }, { procname =3D &quot;listener&qu=
ot;, vpid =3D 24897<br>
&gt; }, { node_handle =3D 0x5CCBD0EFA280, rmw_handle =3D 0x5CCBD107A420, no=
de_name =3D<br>
&gt; &quot;saturn_listener&quot;, namespace =3D &quot;/hallo/saturn&quot; }=
<br>
&gt; [19:01:41.493613263] (+0.019440755) KARTOFF8xE-zenbook:talker:(24898)<=
br>
&gt; ros2:rcl_node_init: { cpu_id =3D 4 }, { procname =3D &quot;talker&quot=
;, vpid =3D 24898 },<br>
&gt; { node_handle =3D 0x5A8E10DFC6E0, rmw_handle =3D 0x5A8E10F8AA60, node_=
name =3D<br>
&gt; &quot;erde_talker&quot;, namespace =3D &quot;/hallo/erde&quot; }<br>
&gt; <br>
&gt; However, looking deeper into that file I saw that there are all 12<br>
&gt; instances (+some of ros2 itself) I started within the trace-directory<=
br>
&gt; number 10!<br>
&gt; [georg@KARTOFF8xE-zenbook<br>
&gt; /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0=
200-10/ust/pid]$<br>
&gt; ls<br>
&gt; <br>
&gt; listener-24897-20250625-190141=C2=A0 listener-24903-20250625-190141<br=
>
&gt;=C2=A0 =C2=A0ros2-24447-20250625-190131=C2=A0 ros2-24887-20250625-19014=
1<br>
&gt;=C2=A0 =C2=A0talker-24900-20250625-190141=C2=A0 talker-24916-20250625-1=
90141<br>
&gt; listener-24899-20250625-190141=C2=A0 listener-24914-20250625-190141<br=
>
&gt;=C2=A0 =C2=A0ros2-24451-20250625-190131=C2=A0 talker-24896-20250625-190=
141<br>
&gt;=C2=A0 =C2=A0talker-24902-20250625-190141<br>
&gt; listener-24901-20250625-190141=C2=A0 listener-24917-20250625-190141<br=
>
&gt;=C2=A0 =C2=A0ros2-24834-20250625-190134=C2=A0 talker-24898-20250625-190=
141<br>
&gt;=C2=A0 =C2=A0talker-24904-20250625-190141<br>
&gt; <br>
&gt; BUT:<br>
&gt; I looked into the specific directory of a traced instance (underlined =
it)<br>
&gt; [georg@KARTOFF8xE-zenbook<br>
&gt; /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0=
200-10/ust/pid]$<br>
&gt; ls listener-*24897*-20250625-190141/<br>
&gt; <br>
&gt; index=C2=A0 =C2=A0 =C2=A0structuralChannel_0=C2=A0 structuralChannel_2=
=C2=A0 structuralChannel_4<br>
&gt;=C2=A0 =C2=A0structuralChannel_6=C2=A0 structuralChannel_8=C2=A0 struct=
uralChannel_10<br>
&gt; *metadata*=C2=A0 structuralChannel_1=C2=A0 structuralChannel_3=C2=A0 s=
tructuralChannel_5<br>
&gt;=C2=A0 =C2=A0structuralChannel_7=C2=A0 structuralChannel_9=C2=A0 struct=
uralChannel_11<br>
&gt; <br>
&gt; and of a non-traced instance:<br>
&gt; [georg@KARTOFF8xE-zenbook=C2=A0 =C2=A0 =C2=A0<br>
&gt; /tmp/structural_traces/archives/20250625T190141+0200-20250625T190142+0=
200-10/ust/pid]$<br>
&gt; ls listener-24899-20250625-190141<br>
&gt; <br>
&gt; index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 structura=
lChannel_1=C2=A0 structuralChannel_3<br>
&gt;=C2=A0 =C2=A0structuralChannel_5=C2=A0 structuralChannel_7=C2=A0 struct=
uralChannel_9<br>
&gt; structuralChannel_11<br>
&gt; structuralChannel_0=C2=A0 structuralChannel_2=C2=A0 structuralChannel_=
4<br>
&gt;=C2=A0 =C2=A0structuralChannel_6=C2=A0 structuralChannel_8=C2=A0 struct=
uralChannel_10<br>
&gt; <br>
&gt; Turns out: There is no metadata file within the second one. Therefore<=
br>
&gt; babeltrace2 is not able to parse the file. Do you have an idea why?<br=
>
&gt; <br>
<br>
=C2=A0From your later e-mail with the updated sessiond log which shows the =
<br>
PERROR for too many open files it sounds like you have a thread to pull on.=
<br>
<br>
You can try using the per-uid buffering scheme to reduce the number of <br>
FDs required when running 12 concurrent instances of ros.<br>
<br>
&gt; Best regards,<br>
&gt; Georg<br>
&gt; <br>
&gt; Never burn the bridges before you<br>
&gt; If you&#39;ve burned the bridges behind<br>
&gt; Never burn the one that you&#39;re walking upon<br>
&gt; Or you&#39;re sure to hit the water in time. *(Savatage, Streets, 1991=
)*<br>
&gt; <br>
&gt; <br>
&gt; Am Mi., 25. Juni 2025 um 17:50 Uhr schrieb Kienan Stewart &lt;<br>
&gt; <a href=3D"mailto:kstewart@efficios.com" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">kstewart@efficios.com</a>&gt;:<br>
&gt; <br>
&gt;&gt; Hi Georg,<br>
&gt;&gt;<br>
&gt;&gt; On 6/25/25 9:36 AM, Georg Muck wrote:<br>
&gt;&gt;&gt; Hi Kienan,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I did exactly that, without success.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The log of the lttng-sessiond (lttng.log) did not change after=
 starting<br>
&gt;&gt; the<br>
&gt;&gt;&gt; ROS2 instances. I have also added the output of &quot;lttng li=
st<br>
&gt;&gt;&gt; structuralSession&quot;<br>
&gt;&gt;&gt; I start my tracing instance as follows:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; At first there is a bash-script that sets everything up, it do=
es the<br>
&gt;&gt;&gt; following:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; lttng destroy -a # to destroy all existing sessions<br>
&gt;&gt;&gt; lttng-sessiond --daemonize --verbose-consumer -vvv &amp;&gt; &=
quot;/tmp/lttng.log&quot; #<br>
&gt;&gt;<br>
&gt;&gt; When started with &#39;--daemonize&#39;, the file descriptors are =
closed[1]<br>
&gt;&gt; after forking which is why you don&#39;t see any further output to=
<br>
&gt;&gt; /tmp/lttng.log. Try with &#39;--background&#39; instead.<br>
&gt;&gt;<br>
&gt;&gt;&gt; starting a new session Deamon<br>
&gt;&gt;&gt; ./exemplary_tracing_session # starting my exemplary tracing se=
ssion<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The exemplary tracing session is written by the help of the c =
Api<br>
&gt;&gt;&gt; (appendix).<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I modified your script to add &#39;tp:tptest&#39; (a tracepoint fr=
om the<br>
&gt;&gt; lttng-tools test suite program gen-ust-events) and did the followi=
ng:<br>
&gt;&gt;<br>
&gt;&gt; ```<br>
&gt;&gt; $ lttng-sessiond --background --verbose-consumer -vvv &amp;&gt; se=
ssiond.log<br>
&gt;&gt; $ ./exemplary_tracing_session &amp;<br>
&gt;&gt; $ lttng-tools/./tests/utils/testapp/gen-ust-events/gen-ust-events<=
br>
&gt;&gt; babeltrace2 /tmp/structural_traces | wc -l<br>
&gt;&gt; 100<br>
&gt;&gt; ```<br>
&gt;&gt;<br>
&gt;&gt; It seems to be working fine for me. A couple of notes:<br>
&gt;&gt;<br>
&gt;&gt; 1. Before any traced application is run, babeltrace2 has the follo=
wing<br>
&gt;&gt; error output: No trace was found based on input `/tmp/structural_t=
races`<br>
&gt;&gt; 2. After a traced application is run whether is produces enabled e=
vents<br>
&gt;&gt; or not, I see the events recorded.<br>
&gt;&gt; 3. When your session script stops, the output folder is deleted.<b=
r>
&gt;&gt;<br>
&gt;&gt;&gt; I started the the same procedure on another machine. The same =
fault<br>
&gt;&gt;<br>
&gt;&gt; The fault is that the babeltrace2 has an error, right? Are you wil=
ling<br>
&gt;&gt; to share your trace that has the problem and/or show the output of=
<br>
&gt;&gt; babeltrace2&#39;s error?<br>
&gt;&gt;<br>
&gt;&gt;&gt; occurred. I think I need to configure more within the `lttngDo=
main`. But<br>
&gt;&gt; I<br>
&gt;&gt;&gt; don&#39;t know how, would you have an idea/hint?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks for your help.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Best regards,<br>
&gt;&gt;&gt; Georg<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Ps.: I also added the log of my tracing tool (structural.log)<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Never burn the bridges before you<br>
&gt;&gt;&gt; If you&#39;ve burned the bridges behind<br>
&gt;&gt;&gt; Never burn the one that you&#39;re walking upon<br>
&gt;&gt;&gt; Or you&#39;re sure to hit the water in time. *(Savatage, Stree=
ts, 1991)*<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am Mo., 23. Juni 2025 um 16:26 Uhr schrieb Kienan Stewart &lt;=
<br>
&gt;&gt;&gt; <a href=3D"mailto:kstewart@efficios.com" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">kstewart@efficios.com</a>&gt;:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Georg,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; a good first step is to run lttng-session with `-vvv --ver=
bose-consumer`<br>
&gt;&gt;&gt;&gt; and inspect the log file and `LTTNG_UST_DEBUG=3D1` in the =
environment.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It may also be useful to run your traced applications with=
<br>
&gt;&gt;&gt;&gt; `LTTNG_UST_DEBUG=3D1` set in the environment.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Do you have steps that reproduce the issue? E.g., all the =
commands to<br>
&gt;&gt;&gt;&gt; set up the tracing session and so forth.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; thanks,<br>
&gt;&gt;&gt;&gt; kienan<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 6/19/25 10:58 AM, Georg Muck via lttng-dev wrote:<br>
&gt;&gt;&gt;&gt;&gt; Hey,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I am using the LTTng tracer (2.13.11, C-API, rotation=
=3D1s) to trace my<br>
&gt;&gt;&gt;&gt; ROS2<br>
&gt;&gt;&gt;&gt;&gt; system (userspace only). Everything works just fine wi=
thin my Docker<br>
&gt;&gt;&gt;&gt;&gt; Container (Ubuntu 24.04), but if I start the same proc=
edure on the host<br>
&gt;&gt;&gt;&gt;&gt; itself (also Ubuntu 24.04), it does not create a Trace=
File if to many<br>
&gt;&gt;&gt;&gt;&gt; tracepoints occur (speaking of roundabout 1500+ per se=
cond) (sometimes<br>
&gt;&gt; it<br>
&gt;&gt;&gt;&gt;&gt; malformed the tracefile, but I was not able to recreat=
e that. If I<br>
&gt;&gt;&gt;&gt; remember<br>
&gt;&gt;&gt;&gt;&gt; correctly, Babeltrace2 threw an error that said that t=
here was no<br>
&gt;&gt;&gt;&gt;&gt; metadata-file). I played around with some configuratio=
ns (like<br>
&gt;&gt; increasing<br>
&gt;&gt;&gt;&gt;&gt; the buffer size from ~16kB to ~512kB or a less aggress=
ive rotation),<br>
&gt;&gt; but<br>
&gt;&gt;&gt;&gt;&gt; the problem stayed.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Would be thankful for help. I guess I delivered to les=
s information,<br>
&gt;&gt;&gt;&gt; please<br>
&gt;&gt;&gt;&gt;&gt; reach out what is interesting at this point, I am not =
sure about that<br>
&gt;&gt; :).<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Best regards,<br>
&gt;&gt;&gt;&gt;&gt; Georg<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Never burn the bridges before you<br>
&gt;&gt;&gt;&gt;&gt; If you&#39;ve burned the bridges behind<br>
&gt;&gt;&gt;&gt;&gt; Never burn the one that you&#39;re walking upon<br>
&gt;&gt;&gt;&gt;&gt; Or you&#39;re sure to hit the water in time. *(Savatag=
e, Streets, 1991)*<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; thanks,<br>
&gt;&gt; kienan<br>
&gt;&gt;<br>
&gt;&gt; [1]: <a href=3D"https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-=
opt--daemonize" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">=
https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-opt--daemonize</a><br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000044cd4c0638754320--
