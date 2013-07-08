From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH 02/23] Add Windows exe files to
	.gitignore
Date: Mon, 8 Jul 2013 10:12:10 -0400
Message-ID: <20130708141210.GC22703__676.106676883315$1373292766$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5382ED5@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCAl-0005Lc-5T
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:12:11 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5382ED5@EU-MBX-01.mgc.mentorg.com>
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

merged as:

commit e9452def10b0edc7dd064bf6f739a61fdd5229f3
Author: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date:   Mon Jul 8 09:49:54 2013 -0400

    Add Windows exe files to .gitignore
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 752308e..dab17d3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -28,3 +28,4 @@ core
>  formats/ctf/metadata/ctf-parser.output
>  stamp-h1
>  babeltrace.pc
> +*.exe
> -- 
> 1.8.1.msysgit.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
