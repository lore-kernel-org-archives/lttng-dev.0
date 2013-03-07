From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [RFC] New LTTng domain attributes
	(buffer/include/exclude)
Date: Thu, 7 Mar 2013 10:19:03 +0100
Message-ID: <51385B87.5010500__46104.9140234993$1362647970$gmane$org@mentor.com>
References: <20130306180313.GA9899@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1UDWyH-0000aA-8C
	for lttng-dev@lists.lttng.org; Thu, 07 Mar 2013 04:18:41 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1UDWyB-0000GW-1x from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Mar 2013 01:18:35 -0800
In-Reply-To: <20130306180313.GA9899@Krystal>
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

On 03/06/2013 07:03 PM, Mathieu Desnoyers wrote:
> Other future attributes we plan on adding are inclusion/exclusion lists,
> followed by a comma-separated list:
> =

>   --include-pid 22,33,44
>   --include-uid 0,5
>   --exclude-pid 12,55
>   --exclude-uid 22

How about child processes of the given pids ? Would it be the default to
also collect their events into the buffer ?

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
