Return-Path: <SRS0=zCFp=LJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD78C48BDF
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Jun 2021 16:16:51 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8328D608FE
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Jun 2021 16:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8328D608FE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4G4D3F2DHfzGx5;
	Tue, 15 Jun 2021 12:16:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623773801;
	bh=S+aHnsl4jn3QAVg2VnqVbRU8RwJn8jzRf6Q0FYUqLuk=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=XbQYCz8qwwbohtVqxyYtsXH8eyz5Ggp4qUHqPnvgnSyV9M7qwl70VugjvoIKkFjC3
	 ELUwHaBYNyb9sDlN9kFrAScqVdbAj+DlrZ0kCJbVKYXeNrMnSPZNC4Nti05KmSf5xu
	 eRlhvV59ZZytigE/IFyDZbePhlAq5E5fzdLIFAkMhDWz/fuYICv0yIEjabeK+TqiJD
	 RQs7uagOUQjjipofKrPSUj9YJ9H7oF6D3uxPDouEUouTZ1v2VhRtIy6Bp00ooK6zc8
	 Zs9vmVkwgdbwLiRO0uVSr81y3zelkgUGKSJNWtVcYg2DTRitHUp5NcSM3pV9bUfT4C
	 1XA3f0PEM8JtA==
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4G4D3D1XdLzFyv
 for <lttng-dev@lists.lttng.org>; Tue, 15 Jun 2021 12:16:40 -0400 (EDT)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 263A6608FE;
 Tue, 15 Jun 2021 15:57:40 +0000 (UTC)
Date: Tue, 15 Jun 2021 11:57:38 -0400
To: Philippe Proulx <pproulx@efficios.com>
Message-ID: <20210615115738.46818ace@oasis.local.home>
In-Reply-To: <CAB4xu_1H-4gdandyRx+F0nb1g+sLKatx=oJdzQspM+3hJXoYhA@mail.gmail.com>
References: <1119833442.5505.1623700847146.JavaMail.zimbra@efficios.com>
 <CAB4xu_1H-4gdandyRx+F0nb1g+sLKatx=oJdzQspM+3hJXoYhA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Subject: Re: [lttng-dev] Usage example of libbabeltrace (babeltrace2) to
 read CTF traces from a GUI
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Steven Rostedt via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Steven Rostedt <rostedt@goodmis.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>,
 Jeremie Galarneau <jgalar@efficios.com>,
 "linux-trace-devel@vger.kernel.org" <linux-trace-devel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

[ Adding linux-trace-devel too ]

On Tue, 15 Jun 2021 11:13:41 -0400
Philippe Proulx <pproulx@efficios.com> wrote:

> On Mon, Jun 14, 2021 at 4:01 PM Mathieu Desnoyers via lttng-dev
> <lttng-dev@lists.lttng.org> wrote:
> >
> > Hi Philippe, Hi Jeremie,
> >
> > Steven is interested to use libbabeltrace as a CTF trace reader in the KernelShark
> > project. It's a GUI which shows Linux kernel traces.
> >
> > He notices that most of the documented usage examples of the libbabeltrace API
> > focus on use-cases where a custom trace format is converted into CTF.
> >
> > I know that the babeltrace2 program is the main user of libbabeltrace at this
> > point, and that it reads CTF as source.
> >
> > For using libbabeltrace as CTF reader for a GUI, what would be the best examples
> > to look at as starting point ? Perhaps the babeltrace2 binary, or just adapt a
> > smaller example program and change the custom trace format source to "ctf.fs" ?
> > Or anything else ?  
> 
> Hello,
> 
> Unfortunately, the Babeltrace 2 C API documentation [1] doesn't offer a
> graph building example at the moment.
> 
> Therefore, indeed, the "best" example would be the babeltrace2(1) CLI
> (see `src/cli`), although I understand that it's a very generic example
> which can be overwhelming to explore.
> 
> However, note that instead of instantiating an existing sink component
> class (as found in a plugin), you'll want to make your own sink
> component class to get access to each event message while also
> controlling the graph operations. Using
> bt_graph_add_simple_sink_component() [2] would be a good start.
> 
> I can cook a minimal working example in the following days.

That would be great, thanks!

-- Steve

> 
> Phil
> 
> [1]: https://babeltrace.org/docs/v2.0/libbabeltrace2/
> [2]: https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-graph.html#gaa8432f03a967d01b764fb1bc959c8e89
> 
> >
> > Thanks,
> >
> > Mathieu
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev  

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
