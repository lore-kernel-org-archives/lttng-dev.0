From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH 00/23] Add MinGW32 libraries to
	executables
Date: Mon, 8 Jul 2013 09:50:12 -0400
Message-ID: <20130708135012.GA22703__11968.4595069431$1373291445$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5382EC1@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwBpV-000595-W0
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 09:50:14 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5382EC1@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> Hi,
> 
> here is the new patch set that makes it possible to compile Babeltrace on MinGW32.
> I have taken your previous comments into account wherever possible.
> 
> This patch set requires the patch I sent earlier, titled " [Babeltrace PATCH 01/01] Move strerror_r to compat directory " , and should be applied on top of that.
> 
> Some notes:
> 
> MinGW, especially MinGW32, is very lacking in library functions. (Indeed, 'minimal').
> Some functions that are found in Microsoft Visual Studio run time libraries are not accessible in MinGW32.
> These include any *_s functions such as strerror_s, gmtime_s, localtime_s and strtok_s; also strnlen is conspicuously missing.
> No byte-swapping function, either.
> 
> It would have been possible to link to those functions dynamically, finding the function address from the DLL etc,
> but I'm not doing it, because in the end, my goal is to create a statically linked tool, with minimal dependencies to shared libraries.
> That is why, instead of using a well-known library function, I have resorted to implementing one on my own.
> 
> I'm still open for any comments that you might have.

I'll go through the patchset. First note: you forgot to add your
Signed-off-by line to your patches (please do for next patches).

Thanks,

Mathieu

> 
> Thanks,
> 
> JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer
> 
> Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
> 
> Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
