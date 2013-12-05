From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: RFC LTTng session and daemon configuration save and
 restore
Date: Thu, 05 Dec 2013 12:12:33 -0500
Message-ID: <52A0B401.8020202__43776.4580398381$1386263645$gmane$org@efficios.com>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [85.12.144.25] (helo=fukushima.klipix.org)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VocTv-0000c2-DZ
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 12:13:09 -0500
In-Reply-To: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

[...]

> 
> LTTng Command Line - Daemon Configuration
> -----------------------------------------
> 
> On launch, the session, relay and consumer daemons will search for files with
> the .conf extension in the following folders, in order of precedence:
> 1) Any path specified using a new --load-config option
Why "load" ?
Why not --config (like openvpn for example) ?
-c or -f would be also good for short options.

> 2) $HOME/.lttng/*.conf
> 3) /etc/lttng/*.conf
> 
> 
> Session Configuration File Format
> ---------------------------------
> 
> The LTTng session configuration file format must enable the serialization of the
> session, channel and event structures of the LTTng API. Since these concepts
> are eminently hierarchical, it only makes sense to use a file format that can
> express such relationships.
> 
> While an INI based file format was the first considered, for its ease of use
> and human readability, it appears that INI provides no standard way of
> expressing hierarchies. It is, of course, possible to flatten session/channel
> hierarchies using prefixed section names, but this is both error prone and
> unsupported by most INI file reading libraries. This means that we would have
> to code our own INI handling code and produce a specification to document our
> additions to the INI format. INI also provides no standard versioning mechanism.
> 
> In keeping with the desire to use a human-readable format, we have considered
> rolling our own format. This format could express hierarchy using tabulations
> to delimit scopes, not unlike the Python language. Such a format would be both
> relatively easy to parse, but also readable. However, this both requires
> documenting the format in a specification, rolling our own parsing and
> validation code, thus losing the benefit of reusing external libraries. This
> option has the highest maintenance cost considering the amount of code and
> documentation to be produced while presenting marginal benefits over the INI
> approach.
Also, we will have fun with debugging the tab vs space issues.
	
> 
> Finally, it seems that using a standard hierarchical format such as JSON or
> XML would be the most appropriate choice. Both of these formats have intrinsic
> support for representation of hierarchical relationships. They also benefit from
> having a lot of hardened external libraries that will provide parsing,
> validation and write support. This is a huge advantage from both
> maintainability and interoperability standpoints. However, both formats
> present the disadvantage of being harder, although minimally, to edit manually.
> It remains to be seen if manual editing of session configurations really is an
> important use-case. Using lttng's save feature would probably prove more
> convenient than editing the files manually. Furthermore, the addition of a
> "dry-run" option to the lttng client would significantly alleviate this pain
> point.
> 
> XML seems like a better option than JSON since it makes it possible to have
> robust file validation using a pre-defined schema. The use of version-specific
> schemas could also be beneficial for backward compatibility as the format
> moves forward. Finally, character encoding handling is already a solved
> problem for most XML libraries.
> 
> 
> LTTng ABI/API
> -------------
> 
> Two new functions are added to the lttng.h API.
> 
> int lttng_load_sessions(const char *url, const char *session_name,
> int flags/struct lttng_session_load_attr *attr);
> 
> Load sessions. If url the is a directory, all .lttng files it contains will be
> loaded. If session_name is NULL, all sessions found in url are restored.
> If a session_name is provided, only this session will be restored.
> 
> A supplementary argument, either a "flags" argument or an attribute structure,
> is used to indicate whether or not the sessions currently known to the
> session daemon should be replaced by the ones found in the configuration
> file(s), provided that their names are the same.
> Even though this is the only current use-case for this argument, a structure
> with a reasonable amount of padding may be more suitable than a primary
> type to accommodate new features. Thoughts?
Would it be possible instead, to have an enum and a len field, to avoid
padding issues ?

> 
> 
> int lttng_save_sessions(const char *url, const char *session_name
> int flags/struct lttng_session_save_attr *attr);
> 
> Save sessions. If url is a directory, the session configuration will be saved
> as session_name.lttng. If a complete file name is provided, the session(s) to be
> saved will be written to this file. If session_name is NULL, all sessions
> currently known to the session daemon will be saved. If a name is provided, only
> that session will be saved.
> 
> The reasoning for the flags/attr argument is the same as for the
> lttng_load_sessions() function, but for a configuration file overwrite
> option.
> 
In save and load, can the URL be a network URL (like the net:// we have) ?
I can easily see a use-case for that in the future, where we would have
a repository of session configurations. Especially in cloud/large-scale
deployments.
I don't think we should rush into implementing that, but having the
interface easy to extend would be interesting.

> 
> LTTng Command Line - Session Configuration
> ------------------------------------------
> 
> Tracing session configurations can be saved and restored using the lttng command
> line client. This capability introduces two new command line options.
> 
> 
> -- Load session configurations --
> 
> $ lttng load -s SESSION_NAME [OPTIONS]
> 
> Loads tracing session configurations.
> 
> .lttng files will be searched in the following default paths, in order of
> precedence:
> 1) $(HOME)/.lttng/sessions
> 2) /etc/lttng/sessions
> 
> A session name or the -a option must be passed as the SESSION_NAME argument.
> Like some other lttng commands, such as enable-event, the -a option stands for
> "all". If this option is used, every session found in the paths will be loaded.
> 
> If a session was saved as active, the tracing for that session will be activated
> automatically on load. The current session configuration of the session daemon
> is also preserved when a configuration is loaded. The new session configurations
> are added to the current session set.
> 
> Tracing sessions saved in an active state will be resumed on load.
> 
> --input-path, -i
> Path in which to search for SESSION_NAME's description. If the path is a
> directory, all .lttng files it contains will be opened and searched for
> SESSION_NAME. If an input path is provided, the -a option will load all
> session configurations found in this path. The default paths are ignored when
> this option is used.
Can we have multiple paths separated by ":" (like $PATH) ?
Also, if we have a configuration path already specified in the sessiond
configuration file, will we override or merge the search paths with -i ?

> 
> --force, -f
> If a restored session's name conflicts with a currently existing session, the
> original session configuration is preserved. However, if the --force option is
> used, the restored session takes precedence. The original session will be
> destroyed.
> 
> 
> -- Save session configurations --
> 
> $ lttng save -s SESSION_NAME [OPTIONS]
> 
> Saves tracing configurations.
> 
> The selected tracing session's configuration will be saved in the
> $HOME/.lttng/sessions folder. If the -a option is used, every session known
> to the session daemon will be saved.
I wonder if we will have trouble with saving only the sessions of our
user (if a root sessiond is running). I think -a will save everything
regardless of the user. Not sure if it is a problem, but we could maybe
specify a uid as well if we want to save all the sessions of a
particular user ?

> 
> --output-path, -o
> If the provided output path is a directory, the session will be saved in a
> file named "SESSION_NAME.lttng". However, if the path is a file, the session(s)
> will all be saved in the same file.
> 
> 

It looks good !

I can't wait to have that for lttngtop ;-) !

Thanks,

Julien
