 <div align="center">
  <img src="https://www.docker.com/wp-content/uploads/2022/03/vertical-logo-monochromatic.png" width=200 alt="vagrant-logo" />
 <h3 align="center">Inception virtual environment</h3>

  <p align="center">
    An awesome Vagrant to jumpstart your development into 42 project : Inception
    <br />
    <a href="https://github.com/hel-kame/inception_vagrant/issues"><strong>Report Bug</strong></a>
    ·
    <a href="https://github.com/hel-kame/inception_vagrant/issues"><strong>Request Feature</strong></a>
  </p>
</div>

---

## Table of contents 
- [About](#about)
- [Getting Started](#started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Vagrant Commands](#vagrant-commands)
- [More](#more)

## About <a name="about"></a>

Vagrant enables the creation and configuration of lightweight, reproducible, and portable development environments.

## Getting Started <a name="started"></a>

### Prerequisites <a name="prerequisites"></a>

To use the environment, you need to have [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed.
<br />
If you have been working from 42 computer, they are already installed.
<br />
So if you don't, you should run:

```shell
curl -L https://raw.githubusercontent.com/hel-kame/inception_vagrant/master/install.sh | bash
```
If you have been working from 42 computer:
<br />
1. Selecting **Preferences** from the **File menu** on the Left-Top in the VM VirtualBox main window. 
2. Then in the displayed window, click on the **General** tab. 
3. Change the Default Machine folder on your `goinfre/`. 

### Installation <a name="installation"></a>

If you have been working from 42 computer, don't forget to do the installation in your `goinfre/`.
<br />
```shell
git clone https://github.com/hel-kame/inception_vagrant.git && cd inception_vagrant && vagrant up
```
Make sure your environment variable `$USER` is the same as your 42 login. 
<br />
If necessary, you can replace the `#{LOCAL_USER}` variable into the `Vagrantfile` with your login if you don't work on 42 computers.
<br />
<br />
All the passwords of each user are **vagrant**.

---

## Usage <a name="usage"></a>

### Vagrant Commands <a name="vagrant-commands"></a>

Let's look at some of the basic commands to control the Vagrant environment.
<br />
To be able to control Vagrant environment, you must be at the location of the `Vagrantfile` :
* **`vagrant up`** - Turns on the environment (or creates it if it doesn't exist yet).
* **`vagrant ssh`** - This connects you to the environment over ssh.
* **`vagrant halt`** - Shutdown the environment.
* **`vagrant status`** - See what the environment is up to.
* **`vagrant destroy`** - Completely delete the environment and all data on it.
* **`vagrant reload`** - Reloads the environment. Useful if you change the Vagrantfile.

## More <a name="more"></a>

You can optimize your work when using a Vagrant environment in several ways.
* [Connect Visual Studio Code with Vagrant in your local machine](https://medium.com/@lopezgand/connect-visual-studio-code-with-vagrant-in-your-local-machine-24903fb4a9de)
