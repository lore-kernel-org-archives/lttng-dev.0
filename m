From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: static versus dynamic linking
	(TRACEPOINT_PROBE_DYNAMIC_LINKAGE)
Date: Mon, 4 Mar 2013 08:57:39 +0100
Message-ID: <513453F3.6040506__21935.6735972271$1362383895$gmane$org@mentor.com>
References: <5133E211.8070909@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1UCQH1-00070A-E1
	for lttng-dev@lists.lttng.org; Mon, 04 Mar 2013 02:57:27 -0500
In-Reply-To: <5133E211.8070909@quantum.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Bryant <david.bryant@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 03/04/2013 12:51 AM, David Bryant wrote:
> Hello,
> =

> I'm trying to decide whether to use static or dynamic tracepoint probe
> linkage. What are the factors that I should consider?

IMHO, whenever you are about to emit tracepoints from shared objects
it's desirable to have the tracepoint provider being a shared object
itself. You will likely want to share the tracepoint provider if you
have e.g. two shared objects that both emit events from the same
tracepoint provider. Also consider dlopend shared objects. When you
unload them via dlclose it would trigger the static dtors to deregister
its tracepoints (in the static tracepoint probe linkage case). If your
application then goes on and tries to emit events of that kind elsewhere
it will not work anymore.

Using dynamic tracepoint providers passes this "application wide
reference counting problem" to the dynamic linker which will not run
dtors that deregister tracepoints as long as some other part of your
application is still referring to it.

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
