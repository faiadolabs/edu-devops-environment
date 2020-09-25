#!/usr/bin/python3
"""
Help
"""
import sys
from os import walk, listdir
from os.path import isfile, isdir, join, abspath

# GitPython (https://gitpython.readthedocs.io/en/stable/intro.html)
from git import Repo, InvalidGitRepositoryError
from git.repo.fun import is_git_dir

#################################################
# UTILS
#################################################
def __pregunta_si_no__(pregunta=""):
    """Dada una pregunta, retorna True o False en función de si la respuesta es afirmativa o negativa"""
    opciones = ["yes", "si", "no", "s", "y", "n"]
    respuesta = None
    while (not respuesta in opciones):
        respuesta = input(bcolors.bold(pregunta + " (yes, no): "))
    return respuesta == "yes" or respuesta == "y" or respuesta == "s"

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    
    @classmethod
    def info(cls, msg): return bcolors.OKBLUE + msg + bcolors.ENDC
    @classmethod
    def ok(cls, msg): return bcolors.OKGREEN + msg + bcolors.ENDC
    @classmethod
    def error(cls, msg): return bcolors.FAIL + msg + bcolors.ENDC
    @classmethod
    def warning(cls, msg): return bcolors.WARNING + msg + bcolors.ENDC
    @classmethod
    def header(cls, msg): return bcolors.HEADER + msg + bcolors.ENDC
    @classmethod
    def bold(cls, msg): return bcolors.BOLD + msg + bcolors.ENDC


def __search_repos__(repos, path):
    for f in listdir(path):
        if isdir(join(path, f)) and is_git_dir(join(path, f, ".git")):
            # Fin recursión. Repo con Workspace
            # print(join(f,"Sí"))
            unRepo = Repo(join(path, f))
            repos.append(unRepo)
        elif isdir(join(path, f)) and is_git_dir(join(path, f)):
            # Fin recursión. Bare Repo
            # print(join(f,"Sí - BARE"))
            unRepo = Repo(join(path, f))
            # print(unRepo, "Es bare? ", unRepo.bare)
            repos.append(unRepo)
        elif isdir(join(path, f)) and not is_git_dir(join(path, f, ".git")): 
            __search_repos__(repos, join(path, f))
        else:
            # Fin recursión
            pass

def __print_repos__(repos):
    print(bcolors.HEADER + "\nRepositorios:\n" + bcolors.ENDC)
    for repo in repos:
        if not repo.bare:
            print(bcolors.info("[REPO]: "), repo)
        else: 
            print(bcolors.warning("[BARE]: "), repo)
    print(bcolors.BOLD + "\nTotal de Respos: ", len(repos), "\n\n" + bcolors.ENDC)
        

def __create_remote__(repo, host, path):
    for un_remote in repo.remotes:
        if un_remote.name == host:
            print(bcolors.warning("[WARN]: "), "Ya existe el remoto {} para {}".format(host, repo))
            return None

    # Procediendo con el nuevo remoto y fetch
    print("CREANDO REMOTO PRO PARA: ", repo)
    return repo.create_remote(host, path)

def __fetch_repos__(*repos, name_remote=None):
    for repo in repos:
        if not repo.bare:
            print("\nRepo, fetching... ", repo.working_tree_dir)
            remotes = repo.remotes if name_remote is None else [repo.remote(name=name_remote)]
            for un_remote in remotes:
                try:
                    fetch_info = un_remote.fetch()
                    print("\t", bcolors.ok("[Ok fetched]"), un_remote)
                except Exception as e:
                    print("\t", bcolors.error("[ERROR fetching]"), un_remote)
    
def __get_dirty_repos__(*repos):
    print(bcolors.HEADER + "\nRepositorios en estado DIRTY:\n" + bcolors.ENDC)
    num_dirty=0
    for repo in repos:
        if not repo.bare and repo.is_dirty(untracked_files=True):
            print(bcolors.warning("[DIRTY REPO]"), repo.working_tree_dir)
            num_dirty += 1
    print(bcolors.BOLD + "\nTotal: {}/{}".format(num_dirty , len(repos)), "\n\n" + bcolors.ENDC)

def __procress_parameters__():
    if len(sys.argv) <= 2: return {} 
    try:
        parametros = {}
        for i in range(3, len(sys.argv), 2):
            parametros[str(sys.argv[i])] = str(sys.argv[i+1])
        return parametros
    except:
        raise "Error al procesar parámetros"


#################################################
# MAIN COMMANDS
#################################################
def help_cmd(**kwargs):
    print(bcolors.error("\nError de sintaxis. Usa:"))
    print("\nFormat: \tedu-git-sync <path> command options\n\n")


def repos(print=True, **kwargs):
    only_repos = []
    __search_repos__(only_repos, mypath)
    if print == True: __print_repos__(only_repos)
    return only_repos


def dirty(**kwargs):
    __get_dirty_repos__(*repos(print=False))


def connect(**kwargs):
    host = kwargs["--host"] if "--host" in kwargs else None
    cadena_conexion = "ssh://enrique@{}".format(host)
    continuar = __pregunta_si_no__(pregunta="La cadena de conexión: "+ cadena_conexion + " es correcta?")
    if continuar:
        print("\n" + bcolors.header("Conectando repos...") + "\n")
        num_conected = 0
        for un_repo in repos(print=False):
            if not un_repo.bare:
                remote_path = cadena_conexion + un_repo.working_tree_dir
                remote = __create_remote__(un_repo, "pro", remote_path)
                if remote: num_conected += 1
        print(bcolors.BOLD + "\nConectados: {}".format(num_conected), "\n\n" + bcolors.ENDC)
    else: 
        bcolors.error("Abortando")
        exit

# Comandos posibles
switch_cmd = {
	"repos": repos,
	"dirty": dirty,
	"connect": connect
}

#################################################
# MAIN SCRIPT
#################################################
try:
    mypath = sys.argv[1]
    mypath = abspath(mypath)
    command = sys.argv[2]
    parametros = __procress_parameters__()
except:
    help_cmd()
    exit()

# tomamos la función asociada a la variable y la invocamos
#switch_cmd.get(command, help_cmd)(**parametros)


