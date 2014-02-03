From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Human read-writeable format for CTF traces
Date: Mon, 3 Feb 2014 11:00:17 -0500 (EST)
Message-ID: <2093535948.9680292.1391443217617.JavaMail.root__27066.4029558704$1391443276$gmane$org@polymtl.ca>
References: <1617414287.17829.1391440364768.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1WALwb-0004fl-A6
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 11:00:26 -0500
In-Reply-To: <1617414287.17829.1391440364768.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


> I would expect that the ctf writer API recently added to babeltrace
> (currently in master branch), along with the Python bindings that cover
> trace read and write APIs, should allow you to implement things like:
> 
> - A plugin to read a CTF trace, and output it in an intermediate format
>   to facilitate edits (e.g. XML as you propose),
> - A plugin to read this XML format and output a CTF trace.

Yes, this would indeed be extremely helpful, in XML and/or JSON.

> You could also generate the XML trace completely by hand if you like, and
> then convert it to CTF with the second plugin I'm relating to above.

The likely scenario is to add a few events by hand.

> Another possibility is that the XML description also allows
> describing what the trace contains at a slightly higher level. For instance, if you
> have a periodic event happening for a certain amount of time, it would
> be described in XML, and then "generated" by the XML-to-CTF
> converter.

Do we want to describe this in XML or in Python? We could have "CTF" to "Python statements" generating XML. Then we could add loops by hand. We could also have CTF to XML, with hooks to merge Python generated events.

In addition, TMF may also want to offer similar functionality, an XML dump of events and an XML events reader. Indeed, TMF supports a few formats other than CTF.
