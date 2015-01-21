From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Out of Tree Kernel Module
Date: Wed, 21 Jan 2015 21:22:59 +0000
Message-ID: <1421875379.22804.3.camel__2829.5568110936$1421875422$gmane$org@c00941>
References: <1421873728.21263.3.camel@c00941> <54C01651.9010102@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from echo.usurf.usu.edu ([129.123.194.129])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.Haws@sdl.usu.edu>) id 1YE2jy-0003M1-5w
 for lttng-dev@lists.lttng.org; Wed, 21 Jan 2015 16:23:10 -0500
In-Reply-To: <54C01651.9010102@voxpopuli.im>
Content-Language: en-US
Content-ID: <29D883FE0E54C347B221550F1E90F096@sdl.usu.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "alexmonthy@voxpopuli.im" <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> I have never tried this myself, but a similar question was asked on 
> StackOverflow recently:
> http://stackoverflow.com/questions/27950396/is-it-possible-to-build-lttng-probe-module-outside-of-lttng-modules-tree
> 
> and the author found a solution. Maybe this can help?

That certainly helps, however I am still having the issue with my kernel
module itself not building.   That link will help me pull my LTTng probe
back into my source directory (highly desirable), but doesn't give me
any information as to why when I build my module (i.e. my driver) that
it is looking for the trace/events/sigma.h file (which doesn't exists,
nor should it - it is exartrace.h).

Thoughts?

Thanks!
Jon
