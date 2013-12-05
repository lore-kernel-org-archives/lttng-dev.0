From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: RFC LTTng session and daemon configuration save and
 restore
Date: Thu, 5 Dec 2013 12:38:07 -0500
Message-ID: <52A0B9FF.4040501__31042.5472948284$1386265151$gmane$org@mentor.com>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1VocsX-0000r3-J0
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 12:38:27 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VocsL-0003X1-4g from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 09:38:09 -0800
In-Reply-To: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi J=E9r=E9mie,



On 12/04/2013 04:33 PM, J=E9r=E9mie Galarneau wrote:
> RFC - LTTng session and daemon configuration save and restore

I think this is a great idea.


> Session Configuration File Format
> ---------------------------------
>
> Finally, it seems that using a standard hierarchical format such as JSON =
or
> XML would be the most appropriate choice. Both of these formats have intr=
insic
> support for representation of hierarchical relationships. They also benef=
it from
> having a lot of hardened external libraries that will provide parsing,
> validation and write support.

I fully agree that re-inventing another language (which includes both
syntax and semantics !) is not an easy task, and should be avoided for
lots of reasons. In fact, I would also avoid XML for that same reason,
as it's not really a language in itself, rather than a baseline on top
of which a language may be defined.

There are a few existing proven solutions that are widely used in many
different domains, all involving scripting languages that can easily be
layered on top of C/C++ APIs. Two of the most commonly used are Python
and Lua, which would allow you to write configuration files as Python /
Lua scripts.

Have you considered those ?

Regards,
        Stefan

-- =

Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
